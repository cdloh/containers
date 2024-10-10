#!/usr/bin/env bash
git clone --quiet https://github.com/sandreas/m4b-tool.git /tmp/m4b-tool
pushd /tmp/m4b-tool > /dev/null || exit
version=$(git rev-list --count --first-parent HEAD)
popd > /dev/null || exit
rm -rf /tmp/m4b-tool
printf "0.5.%d" "${version}"
