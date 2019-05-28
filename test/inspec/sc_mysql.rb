# mysql installed?
describe command('mysqld') do
  it { should exist }
end

# check files
describe file('/etc/supervisor.d/program_mysql.conf') do
  its('md5sum') { should eq '09a61b5d8e1b2627f844db8f935e0bc0' }
end

describe file('/etc/supervisor.d/mysql.conf') do
  it { should_not exist }
end

# check mysql internal data
liveUser = mysql_session('live_user', 'live_password')

describe liveUser.query('SHOW DATABASES') do
  its('stdout') { should include 'live_database' }
  its('stdout') { should_not include 'stage_database' }
end

describe liveUser.query('SELECT VERSION()') do
  its('stdout') { should match /^5.6/ }
end
