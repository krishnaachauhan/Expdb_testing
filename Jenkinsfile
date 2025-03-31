@Library('jenkins-shared-library-main@main') _
pipeline {
    agent {
        label 'Node_37'
    }
    
    environment {
        // Define your remote server credentials and details
        REMOTE_SERVER = '10.150.17.37'
        REMOTE_USER = 'root'
        SSH_KEY = credentials('Node_37') // SSH key credential ID in Jenkins
        // SCRIPT_PATH = '/opt/DB/hello_txt.sh' // Path to script on remote server
        WORKING_DIR = '/opt/DB/' // Directory where script is located
        SCRIPT_NAME = 'create_dir.sh' // Name of the script to execute
        EMAIL_RECIPIENT = 'krishna.chauhan@bankaiinformatics.co.in'
    }
    
    stages {
        stage('Execute Remote Script') {
            steps {
                script {
                    // SSH into the remote server and execute the script
                    sshagent([SSH_KEY]) {
                        // sh """
                        //     ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} \
                        //     'bash -s' < ${SCRIPT_PATH}
                        // """
                        sh """
                            ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} \
                            "cd ${WORKING_DIR} && ./${SCRIPT_NAME}"
                        """
                    }
                    
                    // Alternative if you need to pass parameters:
                    // sh """
                    //     ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_SERVER} \
                    //     '${SCRIPT_PATH} arg1 arg2'
                    // """
                }
            }
        }
    }
    
    post {
        // always {
        //     // Cleanup or notifications can go here
        //     echo 'Remote script execution completed'
        // }
        success {
            emailext(
                subject: "SUCCESS: ${currentBuild.fullDisplayName}",
                body: "Build SUCCESS: Job ${env.JOB_NAME} #${env.BUILD_NUMBER} #${currentBuild.rawBuild.getLog(100).join('\n')}",
                to: env.EMAIL_RECIPIENT,
                // attachmentsPattern: '**/*.tpl'
            )
        }
        failure {
            notification('FAILURE', env.EMAIL_RECIPIENT)
        }
    }
}
