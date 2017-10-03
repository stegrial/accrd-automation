#!/usr/bin/env bash

TARGET_ENV=$1

ARGS=""
case "$TARGET_ENV" in

	"development")

		;;

	"integration")

		;;

	"loading")

		;;

	"prelive")

		;;
	*)
		echo "Unknown environment value!"
		exit 1
		;;
esac

bundler install
ENV=${TARGET_ENV} cucumber -r features