pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                bat 'python -m venv venv'
                bat 'venv\\Scripts\\pip install -r requirements.txt'
            }
        }
        stage('Test') {
            steps {
                bat 'venv\\Scripts\\python -m unittest discover -v'
            }
        }
        stage('Deploy') {
            steps {
                bat 'if not exist deployment mkdir deployment && copy app.py deployment\\'
                bat 'dir deployment'
            }
        }
    }
    post {
        success { echo 'Pipeline succeeded - app deployed.' }
        failure { echo 'Pipeline failed - check the logs.' }
    }
}
