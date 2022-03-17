echo "Provisioning compute VM"
gcloud deployment-manager deployments update test-vm --config ./compute_engine_vm/config.yaml

echo "Deploying biguqery"
gcloud deployment-manager deployments update test-bq --config ./bigquery/config.yaml

echo "Deploying pub sub"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-pub-sub --template ./pubsub/pubsub.jinja --properties topicName:udir-topic,subscriptionName:udir-sub

echo "Deploying google cloud storage"
~/Downloads/google-cloud-sdk/bin/gcloud deployment-manager deployments update test-gcs --config ./gcs/config.yaml

~/Downloads/google-cloud-sdk/bin/gsutil notification create -t $topicName -f json gs://$bucketName