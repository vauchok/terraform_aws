node('slave') {
    slackSend color: '#439FE0', message: "${BUILD_TAG} started in ${BUILD_TIMESTAMP}"
    step('Pull from Git', "git")
    step('Terraform init', "terraform init")
    step('Terraform plan', "terraform plan")
    step('Terraform apply', "terraform apply -auto-approve")
    step('Terraform destroy', "terraform destroy -auto-approve")
    stage('Sending status') {
        slackSend color: 'good', message: "${BUILD_TAG} success!"
    }
}

def step (msg, cmd) {
    stage(msg) {
        try {
            if (cmd == 'git') checkout scm
            else sh "${cmd}"
        }
        catch (Exception e){
            slack_notification (msg, 'Failed')
            throw e
        }
        slack_notification (msg, 'Success')
    }
}

def slack_notification (msg, tag) {
    if (tag == 'Failed') slackSend color: 'danger', message: "${BUILD_TAG} ${tag} <${msg}> stage"
    else slackSend color: 'good', message: "${BUILD_TAG} ${tag} <${msg}> stage"
}
