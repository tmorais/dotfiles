#!/bin/bash

curl 'https://transferwise.com/gateway/v3/comparisons?sendAmount=1000&sourceCurrency=USD&targetCurrency=BRL' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0) Gecko/20100101 Firefox/68.0' -H 'Accept: application/json' -H 'Accept-Language: en_US' --compressed -H 'Referer: https://transferwise.com/br' -H 'Content-Type: application/json' -H 'Time-Zone: America/Sao_Paulo' -H 'Connection: keep-alive' |  jq ".providers[].quotes[].rate" | sort -nr | head -1
