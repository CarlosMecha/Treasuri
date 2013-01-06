# Treasuri

Github: [Treasuri](https://github.com/CarlosMecha/Treasuri)

## License

MIT License

Copyright (C) 2012 Carlos Mecha 

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Description

A exchange rates client. 

## Requirements

Ruby v1.9.1

Gems dependencies:
 - [httpclient](https://github.com/nahi/httpclient)
 - [json](http://flori.github.com/json/)

## Versions

### Release 0.1 (20121021)

* Text-based client.
* Converts 1 USD to EUR and 1 EUR to USD with the actual exchange rate.
* Takes the information from Google Calculator API.

### Release 0.2 (20121202)

* Implemented a data structure helping to create new information sources.
* Added amount parameter to convert: /treasuri.rb \<amount\>

### Alpha 0.3

* Selected currency by command line params: /treasuri.rb \<amount\> \<from\> \<to\>
* Help section.
* Obtaining valid currency codes by [web service](http://www.ezzylearning.com/services/CountryInformationService.asmx/GetCurrencies?)
* YAML file as a local database caching the valid currency codes.
* Optimized calc times.
* Parsed Google Calculator API values.
* Removed global variables.
