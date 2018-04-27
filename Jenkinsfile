node('slave') {

  def branch = 'master'
    
    stage('Pull from Git') {
        try {
            checkout scm: [$class: 'GitSCM', branches: [[name: "*/${branch}"]], userRemoteConfigs: [[url: 'https://github.com/vauchok/terraform_aws.git/']]]
        }
        catch (Exception e){
            slack_notification ('<Pull from Git>', 'Failed')
            throw e
        }
        slack_notification ('<Pull from Git>', 'Success')
    }

    stage('terraform check/init') {
        try {
                sh '''
                  terraform -v
                  terraform init
                '''
        }
        catch (Exception e){
            slack_notification ('<terraform check/init>', 'Failed')
            throw e
        }
        slack_notification ('terraform check/init', 'Success')
    }

    stage('terraform plan') {
        try {
            sh 'terraform plan'
        }
        catch (Exception e){
            slack_notification ('terraform plan', 'Failed')
            throw e
        }
        slack_notification ('terraform plan', 'Success')
    }
  
    stage('terraform apply') {
        try {
            sh 'terraform apply -auto-approve'
        }
        catch (Exception e){
            slack_notification ('terraform apply', 'Failed')
            throw e
        }
        slack_notification ('terraform apply', 'Success')
    }
  
    stage('terraform destroy') {
        try {
            sh 'terraform destroy -auto-approve'
        }
        catch (Exception e){
            slack_notification ('terraform destroy', 'Failed')
            throw e
        }
        slack_notification ('terraform destroy', 'Success')
    }
  
    stage('Sending status') {
        slackSend color: 'good', message: "${BUILD_TAG} Successful deployment!"
    }
}

def slack_notification (message, tag) {
  if (tag == 'Failed') slackSend color: 'danger', message: "${BUILD_TAG} ${tag} ${message} stage"
    else slackSend color: 'good', message: "${BUILD_TAG} ${tag} ${message} stage"
}
