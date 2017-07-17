# sc_mysql

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)

## Overview

Wrapper module for puppetlabs-mysql. Adds the option of having supervisor to manage start script.

## Module Description

This wrapper module adds 2 functions to the puppetlabs-mysql module which are needed at ScaleCommerce.

## Usage

=== Examples
```
class { 'sc_mysql':
  databases => [ 
    database1_name => {
      user => 'username',
      password => 'password',
      host => 'host',
      ...
    }, 
    database2_name => {
      ...
    }
  ],
}
```
hiera example:
```
sc_mysql::databases:
  database1_name:
    user:     'user'
    password: 'password'
    host:     'host'
    grant:    ['All']
    charset:  'utf8'
    collate:  'utf8_general_ci'
```

## Testing

GitLab runner is activated to test after each push.

### InSpec

Configuration testing is done with `InSpec`: https://www.inspec.io/

### Local testing

To test changes before committing them, you can execute the gitlab runner locally.
Unfortunately the official gitlab-runner does not support local testing (according feature request: https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/issues/1359). So we need a custom binary:

1. install docker

1. download gitlab-runner binary

```bash
sudo curl --output /usr/local/bin/gitlab-ci-multi-runner-sc https://gitlab.scale.sc/a.kirchner/gitlab-ci-multi-runner-sc/raw/master/bin/gitlab-ci-multi-runner-sc
sudo chmod +x /usr/local/bin/gitlab-ci-multi-runner-sc
```

1. execute in your working copy

```bash
# mysql 5.6
gitlab-ci-multi-runner-sc exec docker --docker-volumes `pwd`:/tmp/local-working-directory test:sc_mysql:mysql-5.6:ubuntu-14.04

# mysql 5.7
gitlab-ci-multi-runner-sc exec docker --docker-volumes `pwd`:/tmp/local-working-directory test:sc_mysql:mysql-5.7:ubuntu-14.04
```