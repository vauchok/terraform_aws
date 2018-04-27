node('slave') {

  def branch = 'master'
    
    stage('Pull from Git') {
        try {
            checkout scm: [$class: 'GitSCM', branches: [[name: "*/${branch}"]], userRemoteConfigs: [[url: 'https://github.com/vauchok/terraform_aws.git/']]]
        }
        catch (Exception e){
            slack_notification ("${BUILD_TAG} Failed <Pull from Git> stage", "#jenkins-notification", "Ihar Vauchok")
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
            slack_notification ("${BUILD_TAG} Failed <terraform check/init> stage", "#jenkins-notification", "Ihar Vauchok")
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
            slack_notification ("${BUILD_TAG} Failed <terraform plan> stage", "#jenkins-notification", "Ihar Vauchok")
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
            slack_notification ("${BUILD_TAG} Failed <terraform apply> stage", "#jenkins-notification", "Ihar Vauchok")
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
            slack_notification ("${BUILD_TAG} Failed <terraform destroy> stage", "#jenkins-notification", "Ihar Vauchok")
            slackSend color: 'danger', message: "${BUILD_TAG} Failed <terraform destroy> stage"
            throw e
        }
        slackSend color: 'good', message: "${BUILD_TAG} Success <terraform destroy> stage"
    }
  
  stage('Sending status') {
        slack_notification ("${BUILD_TAG} Success!!!", "#jenkins-notification", "Ihar Vauchok")
        slackSend color: 'good', message: "${BUILD_TAG} Success deploy!!!"
  }
}


def slack_notification (message, channel, username) {
    def slack_url = "https://hooks.slack.com/services/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"
    sh "curl -X POST --data-urlencode \'payload={\"channel\": \"${channel}\", \"username\": \"${username}\", \"text\": \"${message}\", \"icon_emoji\": \":ghost:\"}\' \"${slack_url}\""
}
