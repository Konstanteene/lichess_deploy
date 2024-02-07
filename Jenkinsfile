pipeline {
    agent {
        label "agent1"
    }
	environment {
        HOME = "${env.WORKSPACE}"
    }
    stages {
        stage('Test') {
			agent {
                  docker {
                      image 'sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1'
                  }
            steps {
                sh 'ls -l'
				sh 'ls -l lila'
				dir('lila') {
					sh "pwd"
					sh "id"
					sh 'chmod +x lila'
					sh 'ls -la lila'
					sh './lila test'
				}
            }
        }
		stage('Build docker image') {
            steps {
                sh 'docker build -t lichess .'
				sh ''
            }
        }
    }
}
