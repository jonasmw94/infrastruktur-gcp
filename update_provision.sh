# LOAD COMMON VARIABLES
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/common.sh"

echo "Provisioning compute VM"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-vm \
    --template ./compute_engine_vm/vm.py \
    --properties zone:$zone

echo "Deploying pub sub"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-pub-sub \
    --template ./pubsub/pubsub.jinja \
    --properties topicName:$topicName,subscriptionName:$subscriptionName

echo "Deploying google cloud storage"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-gcs \
    --template ./gcs/gcs.py \
    --properties bucketName:$bucketName 

echo "ADDING SUBSCRIPTION TO LISTEN FOR NOTIFICATIONS"
~/Downloads/google-cloud-sdk/bin/gsutil notification update -t $topicName -f json gs://$bucketName
