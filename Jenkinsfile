node('slave') {

  def branch = 'master'

  stage('Pull from Git') {
    checkout scm: [$class: 'GitSCM', branches: [[name: "*/${branch}"]], userRemoteConfigs: [[url: 'https://github.com/vauchok/terraform_aws.git/']]]
  }

  stage('terraform check/init') {
    sh '''
      terraform -v
      terraform init
    '''
  }

  stage('terraform plan') {
    sh 'terraform plan'
  }

  stage('terraform apply') {
    sh 'terraform apply -auto-approve'
  }
  
  stage('terraform destroy') {
    sh 'terraform destroy -auto-approve'
  }
  
}
