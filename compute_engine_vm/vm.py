def GenerateConfig(context):
    """Generate configuration."""

    resources = []
    resources.append({
        'name': 'vm-' + context.env['deployment'],
        'type': 'compute.v1.instance',
        'properties': {
            'zone': context.properties['zone'],
            'machineType': ''.join(['zones/', context.properties['zone'], '/machineTypes/n1-standard-1']),
            'disks': [{
                'deviceName': 'boot',
                'type': 'PERSISTENT',
                'boot': True,
                'autoDelete': True,
                'initializeParams': {
                    'sourceImage':
                        'projects/debian-cloud/global/images/family/debian-9'
                }
            }],
            'networkInterfaces': [{
                'network': 'global/networks/default'
            }]
        }

    })

    return { 'resources': resources }