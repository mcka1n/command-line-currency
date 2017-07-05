require 'twilio-ruby'

module CommandLineCurrency
  class Sms
    def self.send_text_message(to_phone_number, body_message)
      account_sid = ENV['TWILIO_ACCOUNT_SID']
      auth_token = ENV['TWILIO_AUTH_TOKEN']
      your_twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']

      begin
        @client = Twilio::REST::Client.new account_sid, auth_token
        message = @client.account.messages.create(
          :body => body_message,
          :to => to_phone_number,
          :from => your_twilio_phone_number
        )
      rescue Twilio::REST::RequestError => e
          puts e.message
      end
    end
  end
end
