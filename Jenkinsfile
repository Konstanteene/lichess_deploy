pipeline {
	agent { label "agent1" }
	environment {
    	HOME = "${env.WORKSPACE}"
    	LILA_IP = credentials('LILA_IP')
    	LILA_WS_IP = credentials('LILA_WS_IP')
    	REMOTE_SERVER_IP = credentials('remote_server_ip')
    	DOCKER_HUB_USER = credentials('dockerHub').username
    	DOCKER_HUB_PASS = credentials('dockerHub').password
    }
    stages {
       stage('Test') {
    		steps{
        		script {
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
                sh "docker tag lichess ${DOCKER_HUB_USER}/lichess:latest"
                sh "docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASS}"
                sh "docker push ${DOCKER_HUB_USER}/lichess:latest"
            }
        } 
    	stage("Deploy"){
      	steps{
        	script{
          		def dockerComposeBuild = 'docker compose -f /home/app/docker-compose.yml build'
          		def dockerComposeUp = 'docker compose -f /home/app/docker-compose.yml up -d'
          		def exportVars = "export LILA_IP=${LILA_IP} && export LILA_WS_IP=${LILA_WS_IP} && source ~/.bashrc"
          		sshagent(['remote-server-ssh-key']){
            		sh "scp docker-compose.yml root@${REMOTE_SERVER_IP}:/home/app/"
            		sh "ssh -o StrictHostKeyChecking=no root@${REMOTE_SERVER_IP} '${exportVars} && ${dockerComposeBuild} && ${dockerComposeUp}'"
          }
        }
      }
    }
  }
  	post {
    	always {
      		cleanWs()
    	}
  	}
}