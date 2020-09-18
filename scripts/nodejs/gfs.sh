#!/bin/bash

URL=$1
curl -H "Accept: application/json" $URL | json2csv -s -d "," 
