#!/usr/bin/env bash

cd "$(dirname "$0")"

[ -d report ] && rm -rf report
    
mkdir report

pybot --outputdir report/ .
