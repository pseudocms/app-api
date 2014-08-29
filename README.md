# PseudoCMS Hosted API

[![Build Status](https://travis-ci.org/pseudocms/app-api.svg?branch=master)](https://travis-ci.org/pseudocms/app-api)

## API Details

### Versioned with Accept Header

* Use `Accept: vnd.pseudocms.v[N]+json` where `[N]` is the version number.

### All Responses Contain a Unique Request Id

This can be found in the response header `X-Request-Id`. It will be a unique value in the
`8-4-4-4-12` format.

### Always Use Standard UTC Timestamps

This API accepts and returns times in UTC format only. Rendered times will be in ISO8601 format. For
example: `2014-01-01T13:00:00Z`.

## Development Details

### Ruby version

Tested against Ruby 2.1.2

### Configuration

* Initial setup: `script/setup`
* Alter _config/database.yml_ and _config/application.yml_ as necessary

### Database creation

`rake db:setup`

### How to run the test suite

* Run all tests: `rake`
* Run single test file: `spring testunit <file>`
* Run single test: `spring testunit <file> -n "<test_name>"`

### Deployment instructions

`git push production master`
