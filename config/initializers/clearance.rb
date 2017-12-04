Clearance.configure do |config|
  config.mailer_sender = "no-reply@#{ENV['SITE_HOST']}"
  config.rotate_csrf_on_sign_in = true
  config.routes = false
end
