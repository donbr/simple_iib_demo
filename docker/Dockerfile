# Set the base image to Cent OS 7
FROM centos:7

# Update yum packages
RUN yum update -y

# Add puppet repository
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# Install puppet agent
RUN yum install puppet-agent-1.9.3 --nogpg -y
