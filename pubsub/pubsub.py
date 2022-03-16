def GenerateConfig(context):
    """Generate configuration."""

    TOPIC_NAME = 'my-topic'
    SUBSCRIPTION_NAME = 'my-sub'

    resources = []
    resources.append({
        'name': TOPIC_NAME,
        'type': 'gcp-types/pubsub-v1:projects.topics',
        'properties': {
            'topic': TOPIC_NAME
        }
    })

    resources.append({
        'name': SUBSCRIPTION_NAME,
        'type': 'gcp-types/pubsub-v1:projects.subscriptions',
        'properties': {
            'subscription': SUBSCRIPTION_NAME,
            'topic': "$(ref.%s.name)".format(TOPIC_NAME)
        }
    })

    return { 'resources': resources }