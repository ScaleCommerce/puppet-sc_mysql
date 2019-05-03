# mysql installed?
describe command('mysqld') do
  it { should exist }
end

liveUser = mysql_session('live_user', 'live_password')

describe liveUser.query('SHOW DATABASES') do
  its('stdout') { should include 'live_database' }
  its('stdout') { should_not include 'stage_database' }
end