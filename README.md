pipeline {
    agent any

    tools {
        maven 'MAVEN-HOME'
    }

    stages {

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                bat 'docker build -t maven-web .'
            }
        }

        stage('Deploy') {
            steps {
                bat '''
                    docker stop maven-web 2>nul
                    docker rm maven-web 2>nul
                    docker run -d --name maven-web -p 8083:8083 maven-web
                '''
            }
        }
    }

    post {
        success {
            emailext(
                subject: "Build SUCCESS: ${env.JOB_NAME}",
                body: "Your application was deployed successfully.",
                to: 'kushalmadhan2403@gmail.com'
            )
        }

        failure {
            emailext(
                subject: "Build FAILURE: ${env.JOB_NAME}",
                body: "Build failed. Check Jenkins console output.",
                to: 'kushalmadhan2403@gmail.com'
            )
        }
    }
}
