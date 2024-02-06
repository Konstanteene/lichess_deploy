pipeline {
    agent {
        docker { image 'sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1' }
    }

    stages {
        stage('Test') {
            steps {
                sh 'ls -l'
				sh 'ls -l lila'
				sh 'chmod +x lila/lila'
				sh 'ls -la lila'
                sh './lila/lila test'
            }
        }
    }
}
