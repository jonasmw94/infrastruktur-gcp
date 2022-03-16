echo "Provisioning compute VM"
gcloud deployment-manager deployments update test-vm --config ./compute_engine_vm/config.yaml

echo "Deploying biguqery"
gcloud deployment-manager deployments update test-bq --config ./bigquery/config.yaml

echo "Deploying pub sub"
gcloud deployment-manager deployments update test-pub-sub --config ./pubsub/config.yaml

echo "Deploying google cloud storage"
gcloud deployment-manager deployments update test-gcs --config ./gcs/config.yaml