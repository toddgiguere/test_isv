#!/bin/bash

# Extract "foo" and "baz" arguments from the input into
# FOO and BAZ shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "THE_PROG=\(.the_prog)"')"

the_result=$(which $THE_PROG)
the_err_result=$(which $THE_PROG 2>&1 1> /dev/null)

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg theresult "$the_result" --arg theerror "$the_err_result" '{"result":$theresult, "error":$theerror}'
