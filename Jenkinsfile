pipeline {
    agent any

    stages {
        stage('Pipeline start') {
            steps {
                print "End stage"
            }
        }

        stage('Configures') {
            options {
                skipDefaultCheckout()
            }

            steps {
                script {
                    GIT_SHORT_HASH = "${env.GIT_COMMIT}".substring(0, 7)
                    SERVICE_NAME = "rails-realworld-example"
                    DOCKER_REGISTRY_IMAGE_NAME = "myartame/$SERVICE_NAME"

                    print "SERVICE_NAME : $SERVICE_NAME"
                    print "GIT_SHORT_HASH : $GIT_SHORT_HASH"
                }
            }
        }

        stage('Build') {
            options {
                skipDefaultCheckout()
            }

            steps {
                script {
                    if (!fileExists('Dockerfile')) {
                        error "Dockerfile not found"
                    }

                    try {
                        // container('docker') {
                        //     sh "docker build -t $SERVICE_NAME:$GIT_SHORT_HASH --no-cache ."
                        //     sh "docker tag $SERVICE_NAME:$GIT_SHORT_HASH $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                        //     sh "docker push $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                        // }
                        sh "docker build -t $SERVICE_NAME:$GIT_SHORT_HASH --no-cache ."
                        sh "docker tag $SERVICE_NAME:$GIT_SHORT_HASH $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                        sh "docker push $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                    } catch (e) {
                        error e
                    }
                }
            }
        }

        stage('deploy') {
            options {
                skipDefaultCheckout()
            }
            
            steps {
                script {
                    try {
                        timeout(time: 3, unit: 'MINUTES') {
                            sh "kubectl set image deployment $SERVICE_NAME $SERVICE_NAME=$DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
                        }
                    } catch (e) {
                        sh "kubectl rollout undo deployments $SERVICE_NAME"
                        error e
                    }
                }
            }
        }

        stage('Pipeline end') {
            options {
                skipDefaultCheckout()
            }

            steps {
                print "End stage"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
