pipeline {
    agent { label "agent1" }
	environment {
		HOME = "${env.WORKSPACE}"
    }
    stages {
        stage('Test') {

			steps{
				sh 'ip a'
				sh 'chmod +x lila'
				sh './lila test'
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

