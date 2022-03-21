# LOAD COMMON VARIABLES
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/../common.sh"

~/Downloads/google-cloud-sdk/bin/gcloud functions deploy testPubSub --trigger-topic $topicName  --runtime nodejs16
