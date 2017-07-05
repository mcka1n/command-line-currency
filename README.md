# Command Line Currency

This is a simple tool to check currency rates, it uses the free plan from the https://currencylayer.com

Note: There is an API rate of 1000 for these free plans.

# First things first ...


Let's install the Gems for this project, run:

```
 bundle install
```

In order to run the command line currency operator we need to set the correct
environment variables in the `.env` file.

- There is a .env.sample so we can easily make our new `.env`

## How to use it?

Make sure you are in the project directory

    cd ~/<your-path>/command-line-currency

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
