pipeline {
    agent { label "agent1" }
	environment {
		HOME = "${env.WORKSPACE}"
		LILA_IP = credentials('LILA_IP')
		LILA_WS_IP = credentials('LILA_WS_IP')
		REMOTE_SERVER_IP = credentials('remote_server_ip')
    }
    stages {
 /*       stage('Test') {
			steps{
				script {
					sh "cat application.conf"
					docker.image('sbtscala/scala-sbt:eclipse-temurin-jammy-21.0.2_13_1.9.8_3.3.1').inside{
						dir('lila') {
							sh './lila test'
						}
					}
				}
			}	
		}
		stage("Build docker image"){
			steps{
				sh "cp -r .git lila/"
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
    	} */
		stage("Deploy"){
			steps{
				script{
					def dockerComposeCmd = 'docker compose -f /home/app/docker-compose.yml up -d'
					sshagent(['remote-server-ssh-key']){
						sh "scp docker-compose.yml root@${REMOTE_SERVER_IP}:/home/app/"
						sh "ssh -o StrictHostKeyChecking=no root@${REMOTE_SERVER_IP} ${dockerComposeCmd}"
					}
				}
			}
		}
	}
}

