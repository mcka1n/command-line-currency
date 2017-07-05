load 'lib/command_line_currency/currencylayer.rb'

module CommandLineCurrency
  class Operator
    VALID_CURRENCIES = [
      "AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN",
      "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL",
      "BSD", "BTC", "BTN", "BWP", "BYN", "BYR", "BZD", "CAD", "CDF", "CHF",
      "CLF", "CLP", "CNY", "COP", "CRC", "CUC", "CUP", "CVE", "CZK", "DJF",
      "DKK", "DOP", "DZD", "EEK", "EGP", "ERN", "ETB", "EUR", "FJD", "FKP",
      "GBP", "GEL", "GGP", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD",
      "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "IMP", "INR", "IQD", "IRR",
      "ISK", "JEP", "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KMF", "KPW",
      "KRW", "KWD", "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL",
      "LVL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRO",
      "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK",
      "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG",
      "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK",
      "SGD", "SHP", "SLL", "SOS", "SRD", "STD", "SVC", "SYP", "SZL", "THB",
      "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TWD", "TZS", "UAH", "UGX",
      "USD", "UYU", "UZS", "VEF", "VND", "VUV", "WST", "XAF", "XAG", "XAU",
      "XCD", "XDR", "XOF", "XPF", "YER", "ZAR", "ZMK", "ZMW", "ZWL"
    ]

    def self.exchange_rate(source_currency, target_currencies, specific_date = nil)
      self.validate_input_currency('source', source_currency)
      self.validate_input_currency('target', target_currencies)
      self.validate_date(specific_date)
      target_currencies = target_currencies.join(',')

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
      amount = amount.to_f
      self.validate_input_currency('source', source_currency)
      self.validate_input_currency('target', target_currencies)
      self.validate_date(specific_date)
      self.validate_amount(amount)

      exchange_rates = self.exchange_rate(source_currency, target_currencies, specific_date)
      amount_converted = {}

      exchange_rates.each do |source_to_target_currency, rate|
        amount_converted[source_to_target_currency] = rate * amount
      end

      amount_converted
    end

    def self.best_exchange_rate(source_currency, target_currency)
      self.validate_input_currency('source', source_currency)
      self.validate_input_currency('target', target_currency)

      rates_per_day = {}
      Date.today.downto(Date.today - 7) do |date|
        rates = self.exchange_rate(source_currency, target_currency, date)
        rates_per_day[date.to_s] = rates.first.last      # rate per day
      end

      # Check the highest rate per day
      sorted_rates = rates_per_day.sort_by {|k,v| v}.reverse

      sorted_rates.first
    end

    private

    def self.validate_date(date_string)
      if !date_string.nil?
        y, m, d  = date_string.split '-'

        if !(Date.valid_date? y.to_i, m.to_i, d.to_i)
          raise ArgumentError.new("Invalid date, please enter a valid date in format YYYY-MM-DD")
        end

        # Note: The Currency API works with dates <= to the last 16 years.
        # if y.to_i < Date.today.year - 16
        date_string = Date.parse(date_string)
        base_accepted_date = Date.today.year - 16
        if !date_string.between?(Date.parse("#{base_accepted_date}-01-01"), Date.today)
          raise ArgumentError.new("Invalid date, the date needs to be >= to the last 16 years and <= Today")
        end
      end
    end

    def self.validate_amount(amount)
      raise ArgumentError.new("Invalid amount, please enter number > 0") if amount <= 0
    end

    def self.validate_input_currency(input_type, currencies)
      raise ArgumentError.new("Nil is not a valid #{input_type} currency") if currencies.nil?

      case currencies.class.to_s
      when 'String'
        if !VALID_CURRENCIES.include?(currencies)
          raise ArgumentError.new("Invalid #{input_type} currency code: #{currencies}")
        end
      when 'Array'
        currencies.each do |currency|
          if !VALID_CURRENCIES.include?(currency)
            raise ArgumentError.new("Invalid #{input_type} currency code: #{currency}")
          end
        end
      end
    end
  end
end
