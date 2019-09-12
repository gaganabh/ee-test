#!/bin/bash
yum update -y
yum install java-1.8.0-openjdk-devel
yum install epel-release -y
curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins


yum install ansible -y
