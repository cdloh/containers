# Gets changed images from GIT

set -euo pipefail


declare -a changes_array=()
while read -r app
do
   while read -r channel
   do
    	change="$(jo app="$app" channel="$channel")"
   	changes_array+=($change)
   done < <(jq -e --raw-output -c '.channels[] | .name' "./apps/$app/metadata.json")
done < <(echo '${{ needs.pr-metadata.outputs.addedOrModifiedImages }}' | jq -e --raw-output -c '.[]')

output="$(jo -a ${changes_array[*]})"
echo "::set-output name=changes::${output}"
