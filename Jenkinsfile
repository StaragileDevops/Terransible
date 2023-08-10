node{
    

    stage('git checkout'){
        git 'https://github.com/StaragileDevops/Terransible'
        
    }
    
    
    stage('Initialize Terraform'){
        
        
        
        sh 'terraform init'
        
    }
    
     stage('Plan Terraform'){
         
         withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: '')]) {

        withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: '')]) {
    
        sh 'terraform plan'
        }
         }
     }
        
    
    
   stage('Apply the changes'){
        
        sh 'terraform apply --auto-approve'
        
    }
    
    stage('configuring newly created machine with ansible'){
    
    ansiblePlaybook become: true, credentialsId: 'ansible-keys', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'ansible-playbook.yml'
    }
    
    
    
    /*
    stage('destroy terraform'){
    
    sh 'terraform destroy --auto-approve'
}*/
    
}
