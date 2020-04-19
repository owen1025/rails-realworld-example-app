podTemplate(label: 'test',
    containers: [
        containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true),
        containerTemplate(name: 'kubectl', image: 'lachlanevenson/k8s-kubectl:v1.8.8', command: 'cat', ttyEnabled: true),
    ],
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock')
    ]
) 

{
    node('test') {
        def SERVICE_NAME = "rails-realworld-example"
        def DOCKER_REGISTRY_IMAGE_NAME = "myartame/$SERVICE_NAME"

        stage('configure') {
            print "SERVICE_NAME : $SERVICE_NAME"
        }

        stage('build') {
            container('docker') {
                sh "docker build -t $DOCKER_REGISTRY_IMAGE_NAME:stable --no-cache ."
                sh "docker push $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
            }
        }
    }
}
