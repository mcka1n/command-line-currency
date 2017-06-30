# Command Line Currency

## How to?

### Exchange rate**

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
