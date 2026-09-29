# State Police Bill Tracker: Vercel link

A standalone tracker for the NPBPWG Secretariat, kept **off the main website**.

- **Viewing:** anyone with the link can view it. There is no sign-in. The link is not
  published anywhere, and search engines are told not to list it.
- **Editing:** only people with the **edit passcode** can change anything. The database
  checks the passcode, so hiding the button is not the only protection.
- **Data:** stored in the same Supabase project as the memoranda, in its own table
  (`tracker_docs`). The memorandum portal is not affected.

## This folder

| File | Purpose |
|---|---|
| `index.html` | The tracker |
| `config.js` | Which Supabase project to read from (public key only) |
| `vercel.json`, `robots.txt` | Tell search engines not to index the page |
| `favicon.png` | Browser tab icon |
| `setup/` | This guide and the SQL. The `.vercelignore` file keeps this folder from being uploaded to Vercel. |

---

## Step 1. Update the database (2 minutes)

You already ran the first tracker SQL, so the data is in place. This step switches the
tracker from sign-in to "view with the link, edit with a passcode".

1. Open `setup/tracker-setup.sql` in Notepad.
2. Find `CHANGE-THIS-PASSCODE` and replace it with your passcode. Use at least 12
   characters, for example three unrelated words and a number. Keep the quote marks
   around it.
3. Press Ctrl+A, then Ctrl+C. In Supabase go to **SQL Editor > New query**, paste, and
   click **Run**. You should see "Success. No rows returned".
4. **Close Notepad without saving**, so the passcode is not left in the file.

## Step 2. Put the folder on GitHub (5 minutes)

1. Open **GitHub Desktop**, then **File > Add local repository**, and choose this folder.
2. It will say this is not a Git repository. Click **create a repository here**, then
   **Create repository**.
3. Click **Publish repository**. **Tick "Keep this code private"**, then click Publish.

## Step 3. Deploy on Vercel (5 minutes)

1. Go to vercel.com, then **Add New... > Project**.
2. Import the repository you just published.
3. Framework preset: **Other**. Leave the build settings empty. Click **Deploy**.
4. Your link will be `https://<project-name>.vercel.app`. To change it, go to
   **Settings > General > Project Name**, or **Settings > Domains**. Pick a name that is
   hard to guess, for example `npbpwg-spb-tracker-7k2`.

From now on, whenever the tracker files change, commit and push in GitHub Desktop and
Vercel updates the link automatically.

## Using it

- **Open it:** go to the link. Figures load live, and changes by others appear within
  a second or two.
- **Edit it:** click **Edit data** and enter the passcode. Editing stays unlocked in
  that browser tab until you close it.
- **Update a state:** click it on the map, then use **Update status**, **+ Event**,
  **+ Post**, **+ Story** or **+ Voice**.
- **Export:**
  - **Export PDF** saves a clean A4 landscape PDF, keeping every card whole.
  - **Dashboard (PNG)** saves the whole page as one image.
  - **Website card (PNG)** saves a 1200×630 summary image.
  - Printing from the browser (Ctrl+P) also gives a clean A4 landscape layout.

## Changing the passcode

In Supabase, go to **SQL Editor** and run:

```sql
update public.tracker_secret
   set passcode_hash = extensions.crypt('NEW-PASSCODE', extensions.gen_salt('bf', 10)),
       changed_at = now()
 where id = 1;
```

## Good to know

- **The link is the only lock on viewing.** Share it only with people who should see
  the tracker. If it spreads too far, rename the project in Vercel to get a new link.
- **The database key is public.** The Supabase key in `config.js` is the same public
  key the memorandum portal already uses. Someone technical who has that key and knows
  the table name could read the tracker data directly, but they still could not change
  it without the passcode. The data comes from public reporting, so this is a low risk.
  If that ever matters, ask for a viewing passcode to be added.
