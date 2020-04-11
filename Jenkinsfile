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
                        // def buildImage = docker.build("$SERVICE_NAME:$GIT_SHORT_HASH", "--no-cache .")
                        sh "docker build -t $SERVICE_NAME:$GIT_SHORT_HASH --no-cache ."
                    } catch (e) {
                        error e
                    }
                }
            }
        }

        // stage('Push') {
        //     steps {
        //         script {
        //             try {
        //                 sh "docker tag $SERVICE_NAME:$GIT_SHORT_HASH $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
        //                 sh "docker push $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
        //
        //                 print "$DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH Image push success"
        //             } catch (e) {
        //                 error e
        //             } finally {
        //                 // build 및 registry에 push 이후 Local host의 Docker image 삭제
        //                 sh "docker rmi -f $SERVICE_NAME:$GIT_SHORT_HASH"
        //                 sh "docker rmi -f $DOCKER_REGISTRY_IMAGE_NAME:$GIT_SHORT_HASH"
        //             }
        //         }
        //     }
        // }

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
