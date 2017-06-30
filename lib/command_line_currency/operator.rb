module CommandLineCurrency
  class Operator

    def self.exchange_rate(source_currency, target_currencies, specific_date = nil)
      cli_currency = CommandLineCurrency::Currencylayer.new
      rates = cli_currency.get_exchange_rate(target_currencies + ',' + source_currency, specific_date)
      rates_based_on_source = {}

      if rates[:success]
        rates[:quotes].each do |usd_to_target, usd_to_target_rate|
          target_currency = usd_to_target.to_s.slice(3..5)
          source_to_target = (source_currency + target_currency).to_sym
          usd_to_source = ('USD' + source_currency).to_sym

          rates_based_on_source[source_to_target] = usd_to_target_rate / rates[:quotes][usd_to_source]
        end

        return rates_based_on_source
      end
    end

    def self.convert_amount_to(source_currency, target_currencies, specific_date = nil, amount = 0)
      return if amount <= 0

      exchange_rates = self.exchange_rate(source_currency, target_currencies, specific_date)
      amount_converted = {}

      exchange_rates.each do |source_to_target_currency, rate|
        amount_converted[source_to_target_currency] = rate * amount
      end

      amount_converted
    end
  end
end
