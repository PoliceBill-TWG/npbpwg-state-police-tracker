-- =====================================================================
-- State Police Bill Tracker (Vercel link): Supabase update
-- Run once in Supabase Studio > SQL Editor > New query, in the same
-- project where you ran the first tracker SQL. Safe to run again.
--
-- What it does
--   * Anyone who has the tracker link can VIEW it (no sign-in).
--   * Only someone with the edit passcode can CHANGE it.
--   * The memorandum portal's tables and rules are not touched.
--
-- BEFORE YOU RUN: replace  CHANGE-THIS-PASSCODE  (section 3) with the
-- passcode the Secretariat will use. Use at least 12 characters.
-- =====================================================================

create extension if not exists pgcrypto with schema extensions;

-- 1. Remove the sign-in based rules from the first version -------------
drop policy if exists "members read"   on public.tracker_docs;
drop policy if exists "editors insert" on public.tracker_docs;
drop policy if exists "editors update" on public.tracker_docs;
drop policy if exists "editors delete" on public.tracker_docs;
drop function if exists public.tracker_role();
drop table if exists public.tracker_members;

-- 2. Viewing: open to anyone holding the link --------------------------
drop policy if exists "anyone reads" on public.tracker_docs;
create policy "anyone reads" on public.tracker_docs
  for select to anon, authenticated using (true);
-- There are deliberately no insert, update or delete policies.
-- Changes can only come through the passcode functions below.
revoke insert, update, delete on public.tracker_docs from anon, authenticated;

-- 3. The edit passcode (stored scrambled, never readable) --------------
create table if not exists public.tracker_secret (
  id            int primary key default 1 check (id = 1),
  passcode_hash text not null,
  changed_at    timestamptz not null default now()
);
alter table public.tracker_secret enable row level security;
revoke all on public.tracker_secret from anon, authenticated;

insert into public.tracker_secret (id, passcode_hash)
values (1, extensions.crypt('CHANGE-THIS-PASSCODE', extensions.gen_salt('bf', 10)))
on conflict (id) do update
  set passcode_hash = excluded.passcode_hash, changed_at = now();

-- 4. Passcode-protected actions -----------------------------------------
create or replace function public.tracker_check(p_pass text) returns boolean
  language plpgsql security definer set search_path = public, extensions as $$
begin
  return exists (select 1 from public.tracker_secret
                 where passcode_hash = extensions.crypt(coalesce(p_pass,''), passcode_hash));
end $$;

create or replace function public.tracker_upsert(p_pass text, p_collection text, p_doc_id text, p_data jsonb)
  returns void language plpgsql security definer set search_path = public, extensions as $$
begin
  if not public.tracker_check(p_pass) then
    raise exception 'wrong passcode' using errcode = '28P01';
  end if;
  insert into public.tracker_docs (collection, doc_id, data)
  values (p_collection, p_doc_id, p_data)
  on conflict (collection, doc_id) do update set data = excluded.data;
end $$;

create or replace function public.tracker_delete(p_pass text, p_collection text, p_doc_id text)
  returns void language plpgsql security definer set search_path = public, extensions as $$
begin
  if not public.tracker_check(p_pass) then
    raise exception 'wrong passcode' using errcode = '28P01';
  end if;
  delete from public.tracker_docs where collection = p_collection and doc_id = p_doc_id;
end $$;

revoke all on function public.tracker_check(text) from public;
revoke all on function public.tracker_upsert(text, text, text, jsonb) from public;
revoke all on function public.tracker_delete(text, text, text) from public;
grant execute on function public.tracker_check(text) to anon, authenticated;
grant execute on function public.tracker_upsert(text, text, text, jsonb) to anon, authenticated;
grant execute on function public.tracker_delete(text, text, text) to anon, authenticated;

-- Record who changed what, as far as we can tell (no accounts now).
create or replace function public.tracker_stamp() returns trigger
  language plpgsql as $$
begin
  new.updated_at := now();
  new.updated_by := coalesce(auth.jwt() ->> 'email', 'passcode editor');
  return new;
end $$;

-- =====================================================================
-- To change the passcode later, run only this (with the new passcode):
--   update public.tracker_secret
--      set passcode_hash = extensions.crypt('NEW-PASSCODE', extensions.gen_salt('bf', 10)),
--          changed_at = now()
--    where id = 1;
-- Anyone already editing will be asked for the new one on their next save.
-- =====================================================================
