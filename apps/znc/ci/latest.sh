#!/usr/bin/env bash
version=$(grep FROM apps/znc/Dockerfile  | sed -e 's/.*:\(.*\)@.*/\1/')
printf "%s" "${version}"
