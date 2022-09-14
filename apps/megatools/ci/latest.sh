#!/usr/bin/env bash
git clone --quiet https://megous.com/git/megatools /tmp/megatools
pushd /tmp/megatools > /dev/null || exit
version=$(git log --date-order --tags --simplify-by-decoration --pretty=format:'%D.%cd' --date=format:"%Y%m%d" | head -n1)
popd > /dev/null || exit
rm -rf /tmp/megatools
version="${version#*tag: }"
printf "%s" "${version}"
