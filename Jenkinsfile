pipeline {
    agent any

    stages {
        stage('Pipeline start') {
            steps {
                sendNotification('STARTED')
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
