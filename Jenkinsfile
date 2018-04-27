node('slave') {
    step('Pull from Git', git())
    step('Terraform init', "terraform init")
    step('Terraform plan', "terraform plan")
    step('Terraform apply', "terraform apply -auto-approve")
    step('Terraform destroy', "terraform destroy -auto-approve")
    
    stage('Sending status') {
        slackSend color: 'good', message: "${BUILD_TAG} Successful deployment!"
    }
}

def step (message, cmd) {
    stage(message) {
        try {
            sh "${cmd}"
        }
        catch (Exception e){
            slack_notification (message, 'Failed')
            throw e
        }
        slack_notification (message, 'Success')
    }
}

def slack_notification (message, tag) {
    if (tag == 'Failed') slackSend color: 'danger', message: "${BUILD_TAG} ${tag} ${message} stage"
    else slackSend color: 'good', message: "${BUILD_TAG} ${tag} ${message} stage"
}

def git () {
    checkout scm: [$class: 'GitSCM', branches: [[name: 'master']], userRemoteConfigs: [[url: 'https://github.com/vauchok/terraform_aws.git/']]]
}
