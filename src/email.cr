require "colorize"
require "carbon"
require "../env"

module Mail
  # You can setup defaults in this class
  abstract class BaseEmail < Carbon::Email
    # For example, set up a default 'from' address
    from Carbon::Address.new("My App Name", "hacktonironhacker@gmail.com")
    # Use a string if you just need the email address
    from "hacktonironhacker@gmail.com"
  end

  BaseEmail.configure do |settings|
    settings.adapter = Carbon::SendGridAdapter.new(api_key: ENV["EMAIL_KEY"])
  end

  # Create an email class
  class WelcomeEmail < BaseEmail
    def initialize(@name : String, @email_address : String)
    end

    to @email_address
    subject "Welcome, #{@name}!"
    header "My-Custom-Header", "header-value"
    reply_to "no-reply@noreply.com"
    # You can also do just `text` or `html` if you don't want both
    templates text, html 
  end

  class CryptoGotValue < BaseEmail
    def initialize(@name : String, @symbol : String, @value : String, @email_address : String)
    end

    to @email_address
    subject "[UPDATE CRYPTO] Crypto got value"
    header "My-Custom-Header", "header-value"
    reply_to "no-reply@noreply.com"
    # You can also do just `text` or `html` if you don't want both
    templates text, html 
  end
end

# p Mail::WelcomeEmail.new("Hacker", "hacktonironhacker@gmail.com").deliver