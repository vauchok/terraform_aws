node('slave') {

  def branch = 'master'

    stage('Pull from Git') {
        try {
            checkout scm: [$class: 'GitSCM', branches: [[name: "*/${branch}"]], userRemoteConfigs: [[url: 'https://github.com/vauchok/terraform_aws.git/']]]
        }
        catch (Exception e){
            slack_notification ("${BUILD_TAG} Failed <Pull from Git> stage", "#jenkins-notification", "Ihar Vauchok")
            throw e
        }
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
            throw e
        }
    }

    stage('terraform plan') {
        try {
            sh 'terraform plan'
        }
        catch (Exception e){
            slack_notification ("${BUILD_TAG} Failed <terraform plan> stage", "#jenkins-notification", "Ihar Vauchok")
            throw e
        }
    }
  
    stage('terraform apply') {
        try {
            sh 'terraform apply -auto-approve'
        }
        catch (Exception e){
            slack_notification ("${BUILD_TAG} Failed <terraform apply> stage", "#jenkins-notification", "Ihar Vauchok")
            throw e
        }
    }
  
    stage('terraform destroy') {
        try {
            sh 'terraform destroy -auto-approve'
        }
        catch (Exception e){
            slack_notification ("${BUILD_TAG} Failed <terraform destroy> stage", "#jenkins-notification", "Ihar Vauchok")
            throw e
        }
    }
  
  stage('Sending status') {
        slack_notification ("${BUILD_TAG} Success!!!", "#jenkins-notification", "Ihar Vauchok")
  }
}


def slack_notification (message, channel, username) {
    def slack_url = "https://hooks.slack.com/services/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"
    sh "curl -X POST --data-urlencode \'payload={\"channel\": \"${channel}\", \"username\": \"${username}\", \"text\": \"${message}\", \"icon_emoji\": \":ghost:\"}\' \"${slack_url}\""
}
