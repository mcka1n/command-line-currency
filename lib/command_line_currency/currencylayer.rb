require 'rest-client'
require 'openssl'
require 'dotenv'
Dotenv.load

module CommandLineCurrency
  class Currencylayer
    attr_reader :base_url, :api_key

    def initialize
      @base_url = ENV['CURRENCYLAYER_BASE_URL']
      @api_key = ENV['CURRENCYLAYER_API_KEY']
      @currencylayer_resource = RestClient::Resource.new @base_url
    end
  end
end
