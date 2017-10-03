#!/usr/bin/env bash

TARGET_ENV=$1

TAG=""
case "$TARGET_ENV" in

	"development")
	TAG="dev"
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
ENV=${TARGET_ENV} cucumber features --format pretty -p json_report --tags @${TAG}