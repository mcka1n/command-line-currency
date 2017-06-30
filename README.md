# Command Line Currency

# First things first ...

In order to run the command line currency operator we need to set the correct
environment variables in the `.env` file.

- There is a .env.sample so we can easily make our new `.env`

## How to use it?

### Exchange rate

**Request**
```
CommandLineCurrency::Operator.exchange_rate('MXN', 'USD, EUR, CAD')
```

**Response**
````
=> {:MXNUSD=>0.05541363200837677, :MXNEUR=>0.04856461791940542, :MXNCAD=>0.07198114429260925, :MXNMXN=>1.0}
```

### Convert amount from source to multiple targets

**Request**
```
CommandLineCurrency::Operator.convert_amount_to('MXN', 'USD, EUR, CAD', nil, 35)
```

**Response**
````
=> {:MXNUSD=>1.9413168751077086, :MXNEUR=>1.7013778746118962, :MXNCAD=>2.520897028171115, :MXNMXN=>35.0}
```

### Get the highest exchange rate for a currency in the last 7 days

`CommandLineCurrency::Operator.best_exchange_rate('MXN','EUR')`

Response:
["2017-06-26", 0.04991719477182177]`
