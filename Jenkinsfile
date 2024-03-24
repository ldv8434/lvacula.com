pipeline {
    agent  any

    stages {
        stage('Build') {
            steps {
                echo 'run zola build'
                sh 'zola build'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Hello World'
                sshagent(credentials: ['d82f9436-4c96-44c2-9ed3-b21481e7b742']) {
                      sh '''
                       [ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh
                        ssh-keyscan -t rsa,dsa lvacula.com >> ~/.ssh/known_hosts
                      rsync -az -e "ssh -o StrictHostKeyChecking=no" public/. greywolver@lvacula.com:lvacula.com-docker/volumes/blog
                      '''
                   }
            }
        }
    }
}
