def GenerateConfig(context):
    """Generate configuration."""

    resources = []
    resources.append({
        'name': context.properties['bucketName'],
        'type': 'gcp-types/storage-v1:buckets',
        'properties': {
            'predefinedAcl': 'projectPrivate',
            'projection': 'full',
            'location': 'EU',
            'storageClass': 'STANDARD'
        }
    })

    return { 'resources': resources }