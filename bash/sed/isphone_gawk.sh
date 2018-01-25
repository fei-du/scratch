#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error

gawk --re-interval '/^\(?[2-9][0-9]{2}\)?(| |-|\.)[0-9]{3}( |-|\.)[0-9]{4}$/{print $0}'

