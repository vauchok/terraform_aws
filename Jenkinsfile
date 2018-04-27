node('slave') {

  def branch = 'master'
    
    stage('Pull from Git') {
        try {
            checkout scm: [$class: 'GitSCM', branches: [[name: "*/${branch}"]], userRemoteConfigs: [[url: 'https://github.com/vauchok/terraform_aws.git/']]]
        }
        catch (Exception e){
            slackSend color: 'danger', message: "${BUILD_TAG} Failed <Pull from Git> stage"
            throw e
        }
        slackSend color: 'good', message: "${BUILD_TAG} Success <Pull from Git> stage"
    }

    stage('terraform check/init') {
        try {
                sh '''
                  terraform -v
                  terraform init
                '''
        }
        catch (Exception e){
            slackSend color: 'danger', message: "${BUILD_TAG} Failed <terraform check/init> stage"
            throw e
        }
        slackSend color: 'good', message: "${BUILD_TAG} Success <terraform check/init> stage"
    }

    stage('terraform plan') {
        try {
            sh 'terraform plan'
        }
        catch (Exception e){
            slackSend color: 'danger', message: "${BUILD_TAG} Failed <terraform plan> stage"
            throw e
        }
        slackSend color: 'good', message: "${BUILD_TAG} Success <terraform plan> stage"
    }
  
    stage('terraform apply') {
        try {
            sh 'terraform apply -auto-approve'
        }
        catch (Exception e){
            slackSend color: 'danger', message: "${BUILD_TAG} Failed <terraform apply> stage"
            throw e
        }
        slackSend color: 'good', message: "${BUILD_TAG} Success <terraform apply> stage"
    }
  
    stage('terraform destroy') {
        try {
            sh 'terraform destroy -auto-approve'
        }
        catch (Exception e){
            slackSend color: 'danger', message: "${BUILD_TAG} Failed <terraform destroy> stage"
            throw e
        }
        slackSend color: 'good', message: "${BUILD_TAG} Success <terraform destroy> stage"
    }
  
    stage('Sending status') {
        slackSend color: 'good', message: "${BUILD_TAG} Success deploy!!!"
    }
}
