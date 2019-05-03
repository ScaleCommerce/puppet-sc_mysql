#!/bin/bash
#rm /run/cron.pid
export PATH=/opt/puppetlabs/bin:$PATH
sed -i -e "s/nodaemon=true/nodaemon=false/" /etc/supervisord.conf
/usr/local/bin/supervisord -c /etc/supervisord.conf
echo "Running in $(pwd)"
echo "Puppet Version: $(puppet -V)"

# configure puppet
ln -sf $(pwd)/test/hiera.yaml $(puppet config print confdir |cut -d: -f1)/
curl -s https://gitlab.scale.sc/scalecommerce/postinstall/raw/master/puppet.conf > $(puppet config print confdir |cut -d: -f1)/puppet.conf
ln -sf $(pwd)/test/hieradata $(puppet config print confdir |cut -d: -f1)/hieradata
puppet config set certname puppet-test.scalecommerce

# install puppet modules
puppet module install ajcrowe-supervisord
puppet module install puppetlabs-apt --version 2.4.0
puppet module install yo61-logrotate

puppet module install puppetlabs-mysql
puppet module install puppetlabs-stdlib
git clone http://github.com/ScaleCommerce/puppet-sc_supervisor.git $(puppet config print modulepath |cut -d: -f1)/sc_supervisor
git clone https://github.com/ScaleCommerce/puppet-supervisor_provider.git $(puppet config print modulepath |cut -d: -f1)/supervisor_provider
ln -sf $(pwd) $(puppet config print modulepath |cut -d: -f1)/sc_mysql

curl -s https://omnitruck.chef.io/install.sh | bash -s -- -P inspec -v 3.9.3
