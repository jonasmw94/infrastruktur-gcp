echo "Provisioning compute VM"
gcloud deployment-manager deployments create test-vm --config ./compute_engine_vm/config.yaml

echo "Deploying biguqery"
gcloud deployment-manager deployments create test-bq --config ./bigquery/config.yaml

echo "Deploying pub sub"
gcloud deployment-manager deployments create test-pub-sub --config ./pubsub/config.yaml

echo "Deploying google cloud storage"
gcloud deployment-manager deployments create test-gcs --config ./gcs/config.yaml