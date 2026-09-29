/* Supabase connection for the State Police Bill Tracker.
   This is the same public (anon) key the memorandum portal uses. It cannot
   change tracker data: edits need the passcode, checked in the database.
   Never put the service_role key here. */
window.NPB_TRACKER_CONFIG = {
  SUPABASE_URL: "https://alnypgvyvsjbaosvxxyg.supabase.co",
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFsbnlwZ3Z5dnNqYmFvc3Z4eHlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU2OTAxNTksImV4cCI6MjEwMTI2NjE1OX0.fgcjlo_b02MHo_6tNN2vifI6HQQLpRqYExcC--b2FP8"
};
