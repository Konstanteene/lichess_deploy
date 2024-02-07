pipeline {
    agent { label "agent1" }
	environment {
        HOME = "${env.WORKSPACE}"
    }
    stages {
        stage('Test') {
			steps{
				script {
				sh 'ls -l lila/'
				sh 'chmod +x lila/lila'
				sh 'ls -l lila/'	
					docker.image('sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1').withRun{ c ->
						sh 'ip a'
						sh 'docker ps'
						sh 'pwd'
						sh 'ls -l'
						sh './lila test'
					}
				}
			}
		}
	}
}

