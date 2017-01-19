# Changelog

## 0.5.3
* update treasure data repo gpg key

## 0.5.2
* Correct the docs related to the service_enable parameter

## 0.5.1
* Allow to install specific version of fluent gem plugins

## 0.5.0
* Added support for Debian 6, 7, 8
* Added support for CentOS 6, 7
* Added `::fluentd::user`, which manages the td-agent user
* Added parameter `user_manage`
* Added parameter `user_name`
* Added parameter `user_group`
* Added parameter `user_groups`
* Added acceptance tests
* `::fluentd::repo::apt::location default` changed to
  `http://packages.treasuredata.com/2/${::lsbdistid}/${::lsbdistcodename}`
* Small fixes and improvements

## 0.4.0
* Allows definition of multiple directives in matching rules

## 0.3.0
* Increased apt dependency
* Module pinning on rspec tests
* Minor changes

## 0.2.0
* Increased stdlib dependency

## 0.1.0
* Initial release
