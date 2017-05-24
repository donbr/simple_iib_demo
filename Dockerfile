# Set the base image to Cent OS 7
FROM centos:7

# Add puppet repository
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# Update yum packages
RUN yum update -y

# Add hosts entries
# RUN printf "\n127.0.0.1 localhost.localdomain localhost4 localhost4.localdomain4\n" >> etc/hosts
# RUN printf "\n127.0.0.1 localhost.localdomain localhost localhost.localdomain\n"    >> etc/hosts
# RUN printf "\n192.168.253.10 master.example.com puppet master\n"                    >> etc/hosts

# Install git package
RUN yum install git --nogpg -y

# Install puppet agent
RUN yum install puppet-agent-1.9.3 --nogpg -y

# Create Software directory
RUN mkdir /software

# Create vagrant directory
RUN mkdir /vagrant

# Copy contents of demo folder to /vagrant
ADD . /vagrant

# Set up deployments dir
RUN mkdir /etc/puppetlabs/code/environments/production/bar_files

# Install librarian puppet. We need this to download the correct set of puppet modules
RUN ./opt/puppetlabs/puppet/bin/gem install activesupport:4.2.7.1 librarian-puppet awesome_print --no-rdoc --no-ri

# Setup ssh access
RUN mkdir -p ~/.ssh
RUN chmod 700 ~/.ssh
RUN ssh-keyscan -H github.com >> ~/.ssh/known_hosts

# Install required puppet modules
RUN cd /vagrant; /opt/puppetlabs/puppet/bin/librarian-puppet install

# Remove default puppet files
RUN rm -f /etc/puppetlabs/puppet/hiera.yaml /etc/puppetlabs/hiera.yaml /etc/puppetlabs/code/hiera.yaml
RUN rm -rf /etc/puppetlabs/code/environments/production/modules
RUN rm -rf /etc/puppetlabs/code/environments/production/manifests

# Create symlinks to setupfiles
RUN ln -sf /vagrant/hiera.yaml /etc/puppetlabs/code/environments/production/hiera.yaml
RUN ln -sf /vagrant/modules /etc/puppetlabs/code/environments/production
RUN ln -sf /vagrant/manifests /etc/puppetlabs/code/environments/production

# Apply ibm manifest
RUN /opt/puppetlabs/puppet/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp  --verbose --trace
