# LOAD COMMON VARIABLES
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/../common.sh"

echo "Deploying pub sub"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments create test-pub-sub \
    --template ./pubsub/pubsub.jinja \
    --properties topicName:$topicName,subscriptionName:$subscriptionName \
    --quiet