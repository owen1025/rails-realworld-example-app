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
        // def GIT_SHORT_HASH = "${env.GIT_COMMIT}".substring(0, 7)
        // def SERVICE_NAME = "rails-realworld-example"
        // def DOCKER_REGISTRY_IMAGE_NAME = "myartame/$SERVICE_NAME"

        stage('build') {
            container('docker') {
                // sh "docker build -t $SERVICE_NAME:$GIT_SHORT_HASH --no-cache ."
                // sh "docker tag $SERVICE_NAME:$GIT_SHORT_HASH $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                // sh "docker push $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                sh "docker ps -a"
            }
        }
    }
}
