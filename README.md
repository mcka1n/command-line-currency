# Command Line Currency

This is a simple command line tool to check currency rates, it uses the free plan from the https://currencylayer.com

Note: There is an API rate of 1000 for these free plans.

# First things first ...


Let's install the Gems for this project, run:

```
 bundle install
```

In order to run the command line currency we need to set the correct
environment variables in the `.env` file.

There is a `.env.sample` already in this repository, so we can easily make our new `.env`. Use the following command to create your `.env` based on `.env.sample`:

    cp .env.sample .env
    
Now make sure to fill the content with your real credentials.

## How to use it?

Make sure you are in the project directory

    cd ~/<your-path>/command-line-currency
    

These are the things you can do:

  - [Get an exchange rate](#exchange-rate)
  - [Convert an amount from source to target currencies](#convert-amount-from-source-to-multiple-targets)
  - [Get the highest exchange rate in the last 7 days](#get-the-highest-exchange-rate-for-a-currency-in-the-last-7-days)
  - [Send the output via SMS](#sending-the-output-via-sms)
  - [Get help](#get-help)

### Exchange rate

In order to get an exchange rate from a source currency into a target currency, you need to provide the following arguments:

**required arguments**

- -s (source_currency)
- -t (target_currencies; GTM,USD,GBP,EUR)

**optional arguments**
- -d (date, in the YYYY-MM-DD format)

**Example request**
```shell
ruby command_line_currency.rb exchange_rate -s USD -t USD,MXN,EUR
```

**Response**
```
Running exchange_rate on options {:source_currency=>"USD", :target_currencies=>["USD", "MXN", "EUR"]}
{:USDUSD=>1, :USDMXN=>18.3564, :USDEUR=>0.882499}
```

### Convert amount from source to multiple targets

**required arguments**

- -s (source_currency)
- -t (target_currencies; GTM,USD,GBP,EUR)
- -a (amount)

**optional arguments**
- -d (date, in the YYYY-MM-DD format)


**Example request**
```shell
ruby command_line_currency.rb convert_amount_to -s GTQ -t EUR,USD,GBP -a 300.99 -d 2017-07-05
```

**Response**
```
Running convert_amount_to on options {:source_currency=>"GTQ", :target_currencies=>["EUR", "USD", "GBP"], :amount=>"300.99", :date=>"2017-07-05"}
{:GTQEUR=>36.2206597381743, :GTQUSD=>41.05724415712816, :GTQGBP=>31.77091667366891, :GTQGTQ=>300.99}
```

### Get the highest exchange rate for a currency in the last 7 days

**required arguments**

- -s (source_currency: GBP)
- -t (target_currency: EUR)

**Example request**
```
ruby command_line_currency.rb best_exchange_rate -s USD -t EUR
```
**Response:**
```
Running best_exchange_rate on options {:source_currency=>"USD", :target_currencies=>["EUR"]}
2017-07-05
0.882201
```

## Get help

**Run**

```
ruby command_line_currency.rb best_exchange_rate -h
```

**Response**
```
Usage: command_line_currency.rb COMMAND [OPTIONS]

Commands
     exchange_rate: Get the exchange rate of source_currency to N target_currencies using an optional specific_date
     convert_amount_to: Convert an amount from a source_currency to N target_currencies in an optional specific_date
     best_exchange_rate: Get the best exchange rate from a source_currency to a target_currency in the last 7 days

Options
    -s, --source_currency SOURCE     source currency to operate
    -t USD,GBP,MXN,                  target currencies to operate
        --target_currencies
    -d, --date DATE                  specific date to operate (YYYY-MM-DD)
    -a, --amount AMOUNT              specific amount to operate
    -o, --output PHONE_NUMBER        send output to phone-number via SMS (no spaces)
    -h, --help                       help
```

----

## Sending the output via SMS

You can use the optional `-o` flag to send a SMS to a phone number,
you will need to provide some auth keys to the `.env` file.

Example:

```
ruby command_line_currency.rb exchange_rate -s USD -t USD,MXN,EUR -o +49xxxxxxxxxx
```

**Output:**

<img src="https://www.dropbox.com/s/yc3xekije0dfxnq/sms-example.png?dl=1" height="300" />
