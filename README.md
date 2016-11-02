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
sc_mysql::databases:
  database1_name:
    user:     'user'
    password: 'password'
    host:     'host'
    grant:    ['All']
    charset:  'utf8'
    collate:  'utf8_general_ci'
```
