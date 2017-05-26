# Set the base image to Cent OS 7
FROM centos:7

RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm ; \
    yum update -y; \
    yum install puppet-agent-1.9.3 --nogpg -y; \
    mkdir /software; \
    mkdir /vagrant

ADD . /vagrant

RUN mkdir /etc/puppetlabs/code/environments/production/bar_files; \
    rm -f /etc/puppetlabs/puppet/hiera.yaml /etc/puppetlabs/hiera.yaml /etc/puppetlabs/code/hiera.yaml; \
    rm -rf /etc/puppetlabs/code/environments/production/modules; \
    rm -rf /etc/puppetlabs/code/environments/production/manifests; \
    rm -rf /etc/puppetlabs/code/environments/production/hieradata; \
    ln -sf /vagrant/hiera.yaml /etc/puppetlabs/code/environments/production/hiera.yaml; \
    ln -sf /vagrant/modules /etc/puppetlabs/code/environments/production; \
    ln -sf /vagrant/hieradata /etc/puppetlabs/code/environments/production/hieradata; \
    ln -sf /vagrant/manifests /etc/puppetlabs/code/environments/production; \
    cp /etc/puppetlabs/code/environments/production/hieradata/nodes/docker.yaml /etc/puppetlabs/code/environments/production/hieradata/nodes/$(hostname).yaml; \
    /opt/puppetlabs/puppet/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp  --verbose --trace; \
    rm -rf /vagrant/software
