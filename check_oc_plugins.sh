#!/bin/bash

the_result=$(oc plugin list)
the_error_result=$(oc plugin list 2>&1 1> /dev/null)

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg theresult "$the_result" --arg theerror "$the_error_result" '{"result":$theresult, "error":$theerror}'
