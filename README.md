# PseudoCMS Hosted API

[![Build Status](https://travis-ci.org/pseudocms/app-api.svg?branch=master)](https://travis-ci.org/pseudocms/app-api)

## Ruby version

Tested against Ruby 2.1.2

## Configuration

* Initial setup: `script/setup`
* Alter _config/database.yml_ and _config/application.yml_ as necessary

## Database creation

`rake db:setup`

## How to run the test suite

* Run all tests: `rake`
* Run single test file: `spring testunit <file>`
* Run single test: `spring testunit <file> -n "<test_name>"`

## Deployment instructions

`git push production master`
