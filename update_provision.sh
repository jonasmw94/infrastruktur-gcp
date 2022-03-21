# LOAD COMMON VARIABLES
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/common.sh"

echo "Deploying google cloud storage"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-gcs \
    --template ./gcs/gcs.py \
    --properties bucketName:$bucketName \
    --quiet

echo "Provisioning compute VM"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-vm \
    --template ./compute_engine_vm/vm.py \
    --properties zone:$zone \
    --quiet

echo "Provisioning bigquery"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-bigquery \
    --template ./bigquery/bigquery.jinja \
    --properties project:$project \
    --quiet

echo "Deploying pub sub"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-pub-sub \
    --template ./pubsub/pubsub.jinja \
    --properties topicName:$topicName,subscriptionName:$subscriptionName \
    --quiet

cd cloud_function
echo "Deploying function"
~/Downloads/google-cloud-sdk/bin/gcloud functions deploy testPubSub --trigger-topic $topicName  --runtime nodejs16
cd ..

echo "ADDING SUBSCRIPTION TO LISTEN FOR NOTIFICATIONS"
~/Downloads/google-cloud-sdk/bin/gsutil notification create -t $topicName -f json gs://$bucketName