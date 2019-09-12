node{
    stage("clone repo"){
    ws("/home/devops/") {
    	git url: "https://github.com/gaganabh/equal-experts-test.git"
    		}
    		
    	}
	stage("Deploy Infra") {
        	    sh '''terraform apply'''
				}

}
