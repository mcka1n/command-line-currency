require 'spec_helper'

describe CommandLineCurrency::Currencylayer do
  before(:each) do
    # Setting env variables for the test
    ENV['CURRENCYLAYER_BASE_URL'] = 'https://fake-dev.currencylayer.com/v1'
    ENV['CURRENCYLAYER_API_KEY'] = 'a-randome-strong-api-key'
  end

  describe 'initialize' do
    it 'creates a valid object' do
      currencylayer = CommandLineCurrency::Currencylayer.new

      expect(currencylayer).to be_a(CommandLineCurrency::Currencylayer)
      expect(currencylayer.base_url).to eq('https://fake-dev.currencylayer.com/v1')
      expect(currencylayer.api_key).to eq('a-randome-strong-api-key')
    end
  end

  describe 'get_exchange_rate' do
    it 'get the exchange rate' do
      # currencylayer = CommandLineCurrency::Currencylayer.new
      # rates = currencylayer.get_exchange_rate('EUR, GBP')
      #
      # expect(rates).to be_a(Hash)
      # expect(rates).to eq({'EUR':0.10}, {'GBP':1.2})
    end
  end

  describe 'get_best_exchange_rate' do
    # Pending example
  end
end
