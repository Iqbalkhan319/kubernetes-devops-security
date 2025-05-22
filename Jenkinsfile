pipeline {
  agent any

  stages {
    stage('Build Artifact') {
      steps {
        sh "mvn clean package -DskipTests=true"
        archive 'target/*.jar' //so that they can be downloaded later
      }
    } 

    stage('Unit Tests - JUnit and Jacoco') {
      steps {
        sh "mvn test"
      }
    }

    stage('Mutation Tests - PIT') {
      steps {
        sh "mvn org.pitest:pitest-maven:mutationCoverage"
      }
    }

    stage('SonarQube - SAST') {
      steps {
        withSonarQubeEnv('sonarqube-server') {
          sh "mvn clean verify sonar:sonar -Dsonar.projectKey=numericapp -Dsonar.projectName='numericapp' -Dsonar.host.url=http://172.16.188.160:9000"
        }
        timeout(time: 2, unit: 'MINUTES') {
          script {
            waitForQualityGate abortPipeline: true
          }
        }
      }
    }

    stage('Vulnerability Scan--Docker-') {
      parallel {
        stage('Dependency Scan') {
          steps {
            sh 'mvn org.owasp:dependency-check-maven:check'
          }
        }
        stage('Trivy Scan') {
          steps {
            sh 'bash trivy-docker-image.sh'
          }
        }
      }
    }

    stage('Dockerbuild and Push') {
      steps {
        withDockerRegistry([credentialsId: "docker-hub", url: ""]){
          sh 'printenv'
          sh 'sudo docker build -t iqbalkhan319/numeric-app:$GIT_COMMIT .'
          sh 'docker push iqbalkhan319/numeric-app:$GIT_COMMIT'
        }
      }
    } 

    stage('kubernetes deployment - DEV') {
      steps {
        withKubeConfig([credentialsId: 'kubeconfig']) {
          sh "sed -i 's#replace#iqbalkhan319/numeric-app:${GIT_COMMIT}#g' k8s_deployment_service.yaml"
          sh "kubectl apply -f k8s_deployment_service.yaml"
        }
      }
    }
  }

  post {
    always {
      junit 'target/surefire-reports/*.xml'
      jacoco execPattern: 'target/jacoco.exec'
      pitmutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
      dependencyCheckPublisher pattern: 'target/dependency-check-report.xml'
    }
  }
}
