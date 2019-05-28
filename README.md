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

When making changes you can test this module locally with [gitlab-runner on Mac OSX](https://docs.gitlab.com/runner/install/osx.html)

```bash
# mysql 5.6
gitlab-runner exec docker --env "GIT_STRATEGY=none" --docker-volumes `pwd`:/builds/project-0 16.04:sc_mysql:mysql-5.6:puppet5

# mysql 5.7
gitlab-runner exec docker --env "GIT_STRATEGY=none" --docker-volumes `pwd`:/builds/project-0 16.04:sc_mysql:mysql-5.7:puppet5
```
