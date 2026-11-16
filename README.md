# README
node {
    def imageName = "24bd1a665c/oltrs"

    stage('Checkout') {
        git branch: 'master',
            url: 'https://github.com/KushalMadhan3/OLTRS'
    }

    stage('Build') {
        bat 'mvn clean package'
    }

    stage('Test') {
        bat 'mvn test'
    }

    stage('Docker Build') {
        bat "docker build -t ${imageName}:latest ."
    }

    stage('Docker Push') {
        withCredentials([
            usernamePassword(
                credentialsId: 'dockerhub-creds',
                usernameVariable: 'DOCKER_USER',
                passwordVariable: 'DOCKER_PASS'
            )
        ]) {
            bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'

            bat "docker push ${imageName}:latest"

            bat 'docker logout'
        }
    }

    stage('Deploy Complete') {
        echo 'OLTRS CI/CD Pipeline Completed Successfully'
    }
}
