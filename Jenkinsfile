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
        def myRepo
        def gitCommit
        def gitBranch
        def GIT_SHORT_HASH
        def SERVICE_NAME
        def DOCKER_REGISTRY_IMAGE_NAME
        
        stage('checkout') {
            myRepo = checkout scm
            gitCommit = myRepo.GIT_COMMIT
            gitBranch = myRepo.GIT_BRANCH
            GIT_SHORT_HASH = "${gitCommit[0..7]}"
            SERVICE_NAME = "rails-realworld-example"
            DOCKER_REGISTRY_IMAGE_NAME = "myartame/$SERVICE_NAME"
            sh "ls -al"
            print "SERVICE_NAME : $SERVICE_NAME"
            print "GIT_SHORT_HASH : $GIT_SHORT_HASH"
        }

        stage('build and push') {
            container('docker') {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'dockerhub',
                usernameVariable: 'DOCKER_HUB_USER',
                passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
                    sh "docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}"
                    sh "docker build -t $SERVICE_NAME:$GIT_SHORT_HASH --no-cache ."
                    sh "docker tag $SERVICE_NAME:$GIT_SHORT_HASH $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                    sh "docker push $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                }
            }
        }

        stage('deploy') {
            try {
                container('kubectl') {
                    sh "kubectl set image deployment/$SERVICE_NAME rails=$DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH --record"
                }
            } catch(exc) {
                sh "kubectl rollout undo deployments $SERVICE_NAME"
                print "kubectl change image failed"
            }
        }
    }
}
