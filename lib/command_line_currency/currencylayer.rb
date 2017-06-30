require 'rest-client'
require 'openssl'
require 'dotenv'
require 'json'
Dotenv.load

module CommandLineCurrency
  class Currencylayer
    attr_reader :base_url, :api_key

    def initialize
      @base_url = ENV['CURRENCYLAYER_BASE_URL']
      @api_key = ENV['CURRENCYLAYER_API_KEY']
      @currencylayer_resource = RestClient::Resource.new @base_url
    end

    def get_exchange_rate(target_currencies = nil, specific_date = nil)
      # base_currency (String)
      # target_currencies (Array of strings)
      # specific_date <= Today
      params = {}
      params[:access_key] = @api_key
      params[:date] = specific_date || Date.today.strftime("%Y-%m-%d")
      params[:format] = 1

      if !target_currencies.nil? && target_currencies.size > 0
        params[:currencies] = target_currencies
      end

      @currencylayer_resource.options[:headers] = get_headers

      response = @currencylayer_resource["historical"].get({:params => params})
      result = parse(response)
    end

    private

    def get_headers
      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'json'
      }
    end

    def parse(response)
      JSON.parse(response, :symbolize_names => true)
    end
  end
end
