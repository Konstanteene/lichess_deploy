pipeline {
    agent { label "agent1" }
	environment {
        HOME = "${env.WORKSPACE}"
    }
    stages {
        stage('Test') {
			steps{
				script {
				sh 'ls -l'
				sh 'chmod +x lila/lila'
				sh 'ls -l'	
					docker.image('sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1').inside('-v $PWD/lila:/lila') { c ->
						sh 'pwd'
						sh 'ls -l'
						sh 'ls -l lila'
						sh './lila/lila test'
					}
				}
			}
		}
	}
}

