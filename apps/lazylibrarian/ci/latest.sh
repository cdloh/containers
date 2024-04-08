#!/usr/bin/env bash
git clone --quiet https://gitlab.com/LazyLibrarian/LazyLibrarian.git /tmp/lazylibrarian
pushd /tmp/lazylibrarian > /dev/null || exit
version=$(git rev-list --count --first-parent HEAD)
popd > /dev/null || exit
rm -rf /tmp/lazylibrarian
printf "1.0.%d" "${version}"
