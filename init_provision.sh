# COMMON VARIABLES
zone="europe-west1-c"
topicName="udir-topic"
subscriptionName="udir-sub"
bucketName="udir-bucket-strg"

echo "Provisioning compute VM"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments create test-vm \
    --template ./compute_engine_vm/vm.py \
    --properties zone:$zone

echo "Deploying biguqery"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments create test-bq --config ./bigquery/config.yaml

echo "Deploying pub sub"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments create test-pub-sub --template ./pubsub/pubsub.jinja --properties topicName:$topicName,subscriptionName:$subscriptionName

echo "Deploying google cloud storage"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments create test-gcs --config ./gcs/config.yaml

~/Downloads/google-cloud-sdk/bin/gsutil notification create -t $topicName -f json gs://$bucketName