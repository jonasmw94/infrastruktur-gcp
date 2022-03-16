def GenerateConfig(context):
    """Generate configuration."""

    DATASET_NAME = context.env['project'] + "-dataset"
    EMPLOYEE_TABLE_NAME = "employee"

    resources = []

    resources.append({
        'name': DATASET_NAME,
        'type': 'gcp-types/bigquery-v2:datasets',
        'properties': {
            'datasetId': DATASET_NAME,
            'description': "The %s dataset contains all the tables for...".format(DATASET_NAME),
            'location': "US"
        }
    })

    resources.append({
        'name': EMPLOYEE_TABLE_NAME,
        'type': 'gcp-types/bigquery-v2:tables',
        'properties': {
            'datasetId': "$(ref.%s.datasetReference.datasetId)".format(DATASET_NAME),
            'tableReference': {
                'tableId': EMPLOYEE_TABLE_NAME
            },
            'schema': {
                'fields': [
                    { 'name': "emp_id", 'type': "string", 'mode': "REQUIRED" },
                    { 'name': "emp_name", 'type': "string", 'mode': "REQUIRED" },
                    { 'name': "emp_type", 'type': "string", 'mode': "REQUIRED" },
                    { 'name': "depart_name", 'type': "string", 'mode': "REQUIRED" }
                ]
            }
        }
    })

    return { 'resources': resources }