def GenerateConfig(context):
    """Generate configuration."""

    BUCKET_NAME = '%s-resources'.format(env['project'])

    resources = []
    resources.append({
        'name': BUCKET_NAME,
        'type': 'gcp-types/storage-v1:buckets',
        'properties': {
            'predefinedAcl': 'projectPrivate',
            'projection': 'full',
            'location': 'US',
            'storageClass': 'STANDARD'
        }
    })

    return { 'resources': resources }