Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,"ETJZrXJ1Ltslvc4p7Gmtw","9B6onFx8L1bkI3LSgIzhb8oEPfeea6MXaLZHbOMjJOw"
  provider :facebook,"201607206601024","8ef109c956f13c82abbc8f1a67cf2ae8"
end