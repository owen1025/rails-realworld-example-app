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
        def myRepo = checkout scm
        def gitCommit = myRepo.GIT_COMMIT
        def gitBranch = myRepo.GIT_BRANCH
        def GIT_SHORT_HASH = "${gitCommit[0..7]}"
        def SERVICE_NAME = "rails-realworld-example"
        def DOCKER_REGISTRY_IMAGE_NAME = "myartame/$SERVICE_NAME"

        stage('configure') {
            sh "ls -al"
            print "SERVICE_NAME : $SERVICE_NAME"
            print "GIT_SHORT_HASH : $GIT_SHORT_HASH"
        }

        stage('build') {
            container('docker') {
                sh "docker build -t $SERVICE_NAME:$GIT_SHORT_HASH --no-cache ."
                sh "docker tag $SERVICE_NAME:$GIT_SHORT_HASH $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                sh "docker push $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
            }
        }
    }
}
