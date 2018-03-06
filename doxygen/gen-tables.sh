#!/bin/bash

[ $# = 0 ] && exit 1

for i in "$@"; do
	PAGE="${i##*/}"
	PAGE="${PAGE%.c}"
	grep "^ \* [a-z0-9_]\+ - " "$i" \
		| grep \
			-e "\<mutt_" \
			-e "\<default_" \
		| sort \
		| sed \
			-e 's/ \*/|/' \
			-e 's/ - / | /' \
			-e 's/$/ |/' \
			-e 's/\>/()/' \
			-e "1i/** @page $PAGE DUMMY" \
			-e '1i| Function | Description |' \
			-e '1i| :--- | :--- |' \
			-e '$a*/' \
		> "${i%.c}.inc"
done

