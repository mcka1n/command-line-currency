require 'optparse'
require './lib/command_line_currency/operator'
require './lib/command_line_currency/sms'

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: command_line_currency.rb COMMAND [OPTIONS]"
  opt.separator  ""
  opt.separator  "Commands"
  opt.separator  "     exchange_rate: Get the exchange rate of source_currency to N target_currencies using an optional specific_date"
  opt.separator  "     convert_amount_to: Convert an amount from a source_currency to N target_currencies in an optional specific_date"
  opt.separator  "     best_exchange_rate: Get the best exchange rate from a source_currency to a target_currency in the last 7 days"
  opt.separator  ""
  opt.separator  "Options"

  opt.on("-s","--source_currency SOURCE","source currency to operate") do |source_currency|
    options[:source_currency] = source_currency
  end

  opt.on("-t", "--target_currencies USD,GBP,MXN", Array, "target currencies to operate") do |currencies|
    options[:target_currencies] = currencies
  end

  opt.on("-d","--date DATE","specific date to operate (YYYY-MM-DD)") do |date|
    options[:date] = date
  end

  opt.on("-a","--amount AMOUNT","specific amount to operate") do |amount|
    options[:amount] = amount
  end

  opt.on("-o","--output PHONE_NUMBER","send output to phone-number via SMS (no spaces)") do |phone_number|
    options[:phone_number] = phone_number
  end

  opt.on("-h","--help","help") do
    puts opt_parser
  end
end

opt_parser.parse!

case ARGV[0]
when "exchange_rate"
  puts "Running exchange_rate on options #{options.inspect}"
  result = CommandLineCurrency::Operator.exchange_rate(options[:source_currency], options[:target_currencies], options[:date])

  if !options[:phone_number].nil?
    CommandLineCurrency::Sms.send_text_message(options[:phone_number], "exchange_rate for #{options.inspect}, result: #{result}")
  end

  puts result
when "convert_amount_to"
  puts "Running convert_amount_to on options #{options.inspect}"
  result = CommandLineCurrency::Operator.convert_amount_to(options[:source_currency], options[:target_currencies], options[:date], options[:amount])

  if !options[:phone_number].nil?
    CommandLineCurrency::Sms.send_text_message(options[:phone_number], "convert_amount_to for #{options.inspect}, result: #{result}")
  end

  puts result
when "best_exchange_rate"
  puts "Running best_exchange_rate on options #{options.inspect}"
  result = CommandLineCurrency::Operator.best_exchange_rate(options[:source_currency], options[:target_currencies])

  if !options[:phone_number].nil?
    CommandLineCurrency::Sms.send_text_message(options[:phone_number], "best_exchange_rate for #{options.inspect}, result: #{result}")
  end

  puts result
else
  puts opt_parser
end
