# LOAD COMMON VARIABLES
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/../common.sh"

echo "Provisioning bigquery"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-bigquery \
    --template ./bigquery.jinja \
    --properties project:$project \
    --quiet