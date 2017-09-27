#!/usr/bin/env bash

bundle install


case "$1" in

   # Run tests on development instance
   "development") base_url=http://ufrvpndev/accrd-ui/ bundle exec cucumber
   ;;

   # Run tests on integration instance
   "integration") base_url=http://ufrtest/accrd-ui/ bundle exec cucumber
   ;;

   # Run tests on prelive instance
   "prelive") base_url=http://ufrappint4/accrd-ui/ bundle exec cucumber
   ;;

    *) echo "Invalid input. Please use param: development/integration/prelive"
            ;;
esac