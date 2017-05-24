# Set the base image to Cent OS 7
FROM centos:7

# Update yum packages
RUN yum update -y

# Add puppet repository
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# Install git package
RUN yum install git --nogpg -y

# Install puppet agent
RUN yum install puppet-agent-1.9.3 --nogpg -y

# Create Software directory
RUN mkdir /software

# # Set up deployments dir
# RUN mkdir /etc/puppetlabs/code/environments/production/bar_files

# Install librarian puppet. We need this to download the correct set of puppet modules
RUN ./opt/puppetlabs/puppet/bin/gem install activesupport:4.2.7.1 librarian-puppet awesome_print --no-rdoc --no-ri

# Setup ssh access
RUN mkdir -p ~/.ssh
RUN chmod 700 ~/.ssh
RUN ssh-keyscan -H github.com >> ~/.ssh/known_hosts

# Install required puppet modules
RUN ./opt/puppetlabs/puppet/bin/librarian-puppet install

