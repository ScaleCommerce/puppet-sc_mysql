# mysql installed?
describe command('mysqld') do
  it { should exist }
end

liveUser = mysql_session('test_live_user', 'test_live_password')

describe liveUser.query('SHOW DATABASES') do
  its('output') { should include 'test_live_database' }
  its('output') { should_not include 'test_stage_database' }
end