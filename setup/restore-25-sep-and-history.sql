-- =====================================================================
-- State Police Bill Tracker: restore to the 25 Sep 2026 Yoma report
-- and switch on the saved-change history.
-- Run once in Supabase Studio > SQL Editor > New query. No passcode needed.
--
-- WARNING: this replaces EVERYTHING currently in the tracker with the
-- 25 Sep 2026 report data (43 records). Any edits made since are removed.
-- The edit passcode and the memorandum portal are not touched.
-- =====================================================================

-- 1. Allow the new "history" collection (for undoing saved changes)
alter table public.tracker_docs drop constraint if exists tracker_docs_collection_check;
alter table public.tracker_docs add constraint tracker_docs_collection_check
  check (collection in ('states','events','media','voices','themes','risks','actions','meta','history'));

-- 2. Clear the current tracker data (history included)
delete from public.tracker_docs;

-- 3. Put back the 25 Sep 2026 report data
insert into public.tracker_docs (collection, doc_id, data) values
  ('actions','a1',$j${"detail":"Secure direct updates from the Clerk to the National Assembly.","order":1,"status":"open","title":"Establish contact with the Office of the CNA","updatedAt":1790682617175}$j$::jsonb),
  ('actions','a2',$j${"detail":"Continue direct monitoring and flag any further states reporting non-receipt.","order":2,"status":"in_progress","title":"Monitor Houses with unconfirmed transmission","updatedAt":1790682617175}$j$::jsonb),
  ('actions','a3',$j${"detail":"Use established relationships to support review of the bill in their states and get timely state-level updates.","order":3,"status":"open","title":"Engage the six State Attorneys-General","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev01',$j${"createdAt":1790682617175,"date":"2026-09-16","tag":"transmission","text":"Clerk to the National Assembly, Kamoru Ogunlana, announced the Sixth Alteration Bill had been transmitted to the 36 State Houses of Assembly.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev02',$j${"createdAt":1790682617176,"date":"2026-09-22","tag":"context","text":"National Assembly clarified that only the State Police Services bill has been transmitted. Other alteration bills follow once passed in identical form by both chambers.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev03',$j${"createdAt":1790682617177,"date":"2026-09-22","states":["OS"],"tag":"approval","text":"Osun State House of Assembly became the first to endorse the bill.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev04',$j${"createdAt":1790682617178,"date":"2026-09-23","states":["ED"],"tag":"approval","text":"Edo State House of Assembly unanimously approved the bill at plenary in Benin City.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev05',$j${"createdAt":1790682617179,"date":"2026-09-23","states":["PL"],"tag":"review","text":"Plateau received the bill and constituted a committee to scrutinise it.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev06',$j${"createdAt":1790682617180,"date":"2026-09-23","states":["DE","RI","AD","KD","AN","KO","KN"],"tag":"transmission","text":"Conference of Speakers noted Delta, Rivers, Adamawa, Kaduna, Anambra, Kogi and Kano were still awaiting formal transmission.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev07',$j${"createdAt":1790682617181,"date":"2026-09-24","states":["OY","NA"],"tag":"review","text":"Oyo received the bill for consideration. Nasarawa set formal consideration for when plenary resumes on 28 September.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev08',$j${"createdAt":1790682617182,"date":"2026-09-24","states":["RI","AD"],"tag":"transmission","text":"BusinessDay found Rivers had not confirmed transmission, and Adamawa's leadership confirmed it had not received the document.","updatedAt":1790682617175}$j$::jsonb),
  ('events','ev09',$j${"createdAt":1790682617183,"date":"2026-09-25","tag":"context","text":"No further state approvals publicly confirmed. The remaining 34 states are at varying stages.","updatedAt":1790682617175}$j$::jsonb),
  ('media','m01',$j${"date":"2026-09-21","headline":"ADC warns Tinubu govt against weaponising state police ahead 2027","kind":"print","outlet":"BusinessDay","updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('media','m02',$j${"date":"2026-09-22","headline":"Osun Assembly backs creation of state police","kind":"print","outlet":"Nigerian Tribune","states":["OS"],"updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('media','m03',$j${"date":"2026-09-22","headline":"Only State Police Bill transmitted to states, National Assembly clarifies","kind":"print","outlet":"The Sun","updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('media','m04',$j${"date":"2026-09-23","headline":"State Police: Osun first to approve as N'Assembly clarifies transmission","kind":"print","outlet":"Punch","states":["OS"],"updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('media','m05',$j${"date":"2026-09-23","headline":"State police bill in limbo as assemblies await transmission","kind":"print","outlet":"BusinessDay","states":[],"updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('media','m06',$j${"date":"2026-09-24","headline":"Edo Assembly backs State Police constitutional alteration bill","kind":"print","outlet":"Daily Post","states":["ED"],"updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('media','m07',$j${"date":"2026-09-05","headline":"Nnoruka Udechukwu: Heaven forgive us if governors control state police and use it to suppress opposition","kind":"broadcast","outlet":"Arise News","updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('media','m08',$j${"date":"2026-09-24","headline":"State Police: Edo Assembly passes resolution for constitution amendment","kind":"broadcast","outlet":"AIT","states":["ED"],"updatedAt":1790682617175,"url":""}$j$::jsonb),
  ('meta','report',$j${"managedBy":"Admin, NPBPWG Secretariat","period":"22 to 25 Sep 2026","threshold":24,"transmittedOn":"2026-09-16","updatedAt":1790682617175}$j$::jsonb),
  ('risks','r1',$j${"detail":"Rivers, Kano, Adamawa and others could not confirm receipt a week after the national announcement. Confidence in coordination and transparency could erode.","level":"high","title":"Uneven transmission","updatedAt":1790682617175}$j$::jsonb),
  ('risks','r2',$j${"detail":"The \"governors will weaponise state police\" line is the most consistent negative theme and could harden into organised opposition if not addressed in messaging.","level":"high","title":"Political abuse narrative","updatedAt":1790682617175}$j$::jsonb),
  ('risks','r3',$j${"detail":"No official framework yet for how lower-revenue states will fund their services, leaving room for a sceptics' rallying point.","level":"medium","title":"Funding viability unanswered","updatedAt":1790682617175}$j$::jsonb),
  ('states','AD',$j${"date":"2026-09-24","name":"Adamawa","note":"State leadership confirmed it had yet to receive the document from the National Assembly.","source":"BusinessDay","stage":"awaiting","updatedAt":1790682617175,"zone":"NE"}$j$::jsonb),
  ('states','AN',$j${"date":"2026-09-23","name":"Anambra","note":"Listed by the Conference of Speakers as still awaiting formal transmission.","source":"Conference of Speakers","stage":"awaiting","updatedAt":1790682617175,"zone":"SE"}$j$::jsonb),
  ('states','DE',$j${"date":"2026-09-23","name":"Delta","note":"Listed by the Conference of Speakers as still awaiting formal transmission.","source":"Conference of Speakers","stage":"awaiting","updatedAt":1790682617175,"zone":"SS"}$j$::jsonb),
  ('states','ED',$j${"approvedOn":"2026-09-23","date":"2026-09-23","name":"Edo","nextSitting":"2026-09-28","note":"Approved unanimously at plenary in Benin City. Lawmakers cited the security situation and job creation. House adjourned to 28 September.","outcome":"Unanimous","source":"Daily Post; AIT","stage":"approved","updatedAt":1790682617175,"zone":"SS"}$j$::jsonb),
  ('states','KD',$j${"date":"2026-09-23","name":"Kaduna","note":"Listed by the Conference of Speakers as still awaiting formal transmission.","source":"Conference of Speakers","stage":"awaiting","updatedAt":1790682617175,"zone":"NW"}$j$::jsonb),
  ('states','KN',$j${"date":"2026-09-23","name":"Kano","note":"Listed by the Conference of Speakers as still awaiting formal transmission.","source":"Conference of Speakers","stage":"awaiting","updatedAt":1790682617175,"zone":"NW"}$j$::jsonb),
  ('states','KO',$j${"date":"2026-09-23","name":"Kogi","note":"Listed by the Conference of Speakers as still awaiting formal transmission.","source":"Conference of Speakers","stage":"awaiting","updatedAt":1790682617175,"zone":"NC"}$j$::jsonb),
  ('states','NA',$j${"date":"2026-09-24","name":"Nasarawa","nextSitting":"2026-09-28","note":"Formal consideration to begin when plenary resumes on 28 September 2026.","scheduledOn":"2026-09-24","source":"","stage":"scheduled","updatedAt":1790682617175,"zone":"NC"}$j$::jsonb),
  ('states','OS',$j${"approvedOn":"2026-09-22","date":"2026-09-22","name":"Osun","note":"First House to endorse the bill, passing a resolution in its support.","outcome":"Resolution passed","source":"Nigerian Tribune; Punch","stage":"approved","updatedAt":1790682617175,"zone":"SW"}$j$::jsonb),
  ('states','OY',$j${"date":"2026-09-24","name":"Oyo","note":"Received the amendment bill for consideration.","receivedOn":"2026-09-24","source":"","stage":"received","updatedAt":1790682617175,"zone":"SW"}$j$::jsonb),
  ('states','PL',$j${"committeeOn":"2026-09-23","date":"2026-09-23","name":"Plateau","note":"Bill received. A committee has been constituted to scrutinise its provisions and the implications of establishment.","receivedOn":"2026-09-23","source":"","stage":"committee","updatedAt":1790682617175,"zone":"NC"}$j$::jsonb),
  ('states','RI',$j${"date":"2026-09-24","name":"Rivers","note":"Had not confirmed transmission as of press time.","source":"BusinessDay","stage":"awaiting","updatedAt":1790682617175,"zone":"SS"}$j$::jsonb),
  ('themes','t1',$j${"detail":"A decentralised force that can address each state's own challenges is seen as a significant step against recent insecurity.","response":"Share how each approving House links the bill to local security needs, starting with Osun and Edo.","title":"Tackling insecurity locally","updatedAt":1790682617175,"weight":3}$j$::jsonb),
  ('themes','t2',$j${"detail":"The most discussed question is how state police will stay accountable and free from political misuse.","response":"Answer it head-on with clear, published points on oversight and accountability, and engage commentators early.","title":"Safeguards and accountability","updatedAt":1790682617175,"weight":5}$j$::jsonb),
  ('themes','t3',$j${"detail":"People want to know how states with different finances will fund and sustain their own services.","response":"Prepare a clear explainer on funding options for lower-revenue states.","title":"Funding and capacity","updatedAt":1790682617175,"weight":4}$j$::jsonb),
  ('voices','v1',$j${"date":"2026-09-23","quote":"Get a grasp of the security situation, not just in Edo, but across Nigeria.","role":"Lawmakers, plenary vote","states":["ED"],"updatedAt":1790682617175,"who":"Edo State House of Assembly"}$j$::jsonb),
  ('voices','v2',$j${"date":"2026-09-23","quote":"A significant milestone for a safer Nigeria and … a necessary reform for public safety and grassroots security.","role":"Governor, Benue State","states":["BE"],"updatedAt":1790682617175,"who":"Hyacinth Alia"}$j$::jsonb),
  ('voices','v3',$j${"date":"2026-09-05","quote":"Unchecked gubernatorial control over state police could enable abuse of power and political suppression in a winner-takes-all political culture.","role":"Arise News","states":[],"updatedAt":1790682617175,"who":"Nnoruka Udechukwu, SAN"}$j$::jsonb),
  ('voices','v4',$j${"date":"2026-09-21","quote":"Warns the Tinubu government against weaponising state police ahead of 2027.","role":"BusinessDay","states":[],"updatedAt":1790682617175,"who":"African Democratic Congress"}$j$::jsonb);
