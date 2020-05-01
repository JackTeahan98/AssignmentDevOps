pipeline {
  
  environment {
    registryCredential = 'DockerHub'
    registry = "teahands/zoo-application"
    dockerImage = ''
  }
  
  agent any
    
  tools {nodejs "node"}
    
  stages {
    
             stage('Checkout SCM'){
                 steps{
             checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'GitHub', url: 'https://github.com/hoganSean99/Advanced_Database.git']]])
                 }
     }
    
     stage('Code Analysis'){
         steps{
         script {
                 def scannerHome = tool 'sonar-scanner';
                     withSonarQubeEnv("sonar-scanner") {
                     sh "${tool("sonar-scanner")}/bin/sonar-scanner -Dsonar.organization=jackteahan98 -Dsonar.projectKey=JackTeahan98_AssignmentDevOps"
                     }
                         }
                           }
     }
        
    stage('Cloning Git') {
      steps {
        git 'https://github.com/JackTeahan98/AssignmentDevOps'
      }
    }
        
    stage('Install dependencies') {
      steps {
        sh 'npm install'
      }
    }
    stage('Run Tests') {
      steps {
        sh 'npm test'
      }
    }
    
 stage('Rebuild') {
      steps {
        sh 'npm rebuild'
      }
    }
    
    stage('Stop Running Containers') {
      steps {
        sh 'docker rm -f ZooApp > /dev/null 2>&1 && echo \'removed container\' || echo \'nothing to remove\''  
      }
    }
         
    
    stage('Building Image') {
      steps {
        script{dockerImage = docker.build registry + ":$BUILD_NUMBER"}
      }
     } 
    
    stage('Push Image to DockerHub') {
      steps {
        script{docker.withRegistry('',registryCredential){
        dockerImage.push()
        }
      }
     } 
    }
    
    stage('Deploy Application') {
      steps {
        sh 'docker run --name ZooApp -d -p 3000:3000 $registry:$BUILD_NUMBER'
      }
    }
  }
  
  }

