#!/usr/bin/env bash

TARGET_ENV=$1

TAG=""
case "$TARGET_ENV" in

	"development")
	TAG="login"
		;;

	"integration")
    TAG="prod"
		;;

	"loading")
    TAG="prod"
		;;

	"prelive")
    TAG="prod"
		;;
	*)
		echo "Unknown environment value!"
		exit 1
		;;
esac

bundler install
cucumber features --format pretty -p json_report --tags @${TAG} ENV=${TARGET_ENV}
