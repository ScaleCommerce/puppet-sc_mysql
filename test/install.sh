#!/bin/bash
sed -i -e "s/nodaemon=true/nodaemon=false/" /etc/supervisord.conf
/usr/local/bin/supervisord -c /etc/supervisord.conf
apt-get update
apt-get install apt-transport-https
puppet module install ajcrowe-supervisord
puppet module install yo61-logrotate
puppet module install puppetlabs-mysql
puppet module install puppetlabs-stdlib
puppet module install puppetlabs-apt --version 2.4.0
git clone http://github.com/ScaleCommerce/puppet-sc_supervisor.git /etc/puppet/modules/sc_supervisor
curl -s https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec -v 3.9.3
ln -sf /builds/sc-puppet/puppet-sc_mysql/test/hiera.yaml /etc/puppet/
ln -sf /builds/sc-puppet/puppet-sc_mysql/test/hiera /var/lib/hiera
ln -sf /builds/sc-puppet/puppet-sc_mysql/ /etc/puppet/modules/sc_mysql
curl -s https://gitlab.scale.sc/scalecommerce/postinstall/raw/master/puppet.conf > /etc/puppet/puppet.conf
puppet config set certname puppet-test.scalecommerce
