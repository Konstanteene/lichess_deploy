pipeline {
    agent { label "agent1" }
	environment {
		HOME = "${env.WORKSPACE}"
    }
    stages {
        stage('Test') {
			steps{
				script {	
					docker.image('sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1').inside{
						sh 'chmod +x lila'
						sh './lila test'
					}
				}
			}
		}
		stage("Build docker image"){
            steps{
                sh "docker build . -t lichess"
            }
        }
		stage("Push to Docker Hub"){
            steps{
                withCredentials([usernamePassword(credentialsId:"dockerHub",passwordVariable:"dockerHubPass",usernameVariable:"dockerHubUser")]){
					sh "docker tag lichess ${env.dockerHubUser}/lichess:latest"
					sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
					sh "docker push ${env.dockerHubUser}/lichess:latest"
                }
            }
        }
	}
}

