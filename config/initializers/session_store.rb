# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wase_session',
  :secret      => 'e259ccc5038176f418af08cca8ccc970f1dd1759665d48658d3ee3ba95395803e37093a5cc25d7cbb16c94e22a6d2646264314802283481591b0ef1fc0f6e06b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
