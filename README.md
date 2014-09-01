# PseudoCMS Hosted API

[![Build Status](https://travis-ci.org/pseudocms/app-api.svg?branch=master)](https://travis-ci.org/pseudocms/app-api)

## API Details

### Versioned with Accept Header

* Use `Accept: vnd.pseudocms.v[N]+json` where `[N]` is the version number.

### All Responses Contain a Unique Request Id

This can be found in the response header `X-Request-Id`. It will be a unique value in the
`8-4-4-4-12` format.

### Status Codes

Standard HTTP status codes are used throughout this API.

#### POST Requests

POST requests, when successful, will return `HTTP 201` and include the location (URI) for the newly
created resource in the `Location` header.

In some cases where some condition for creating is not satisfied, a `HTTP 412` will be used.

#### PUT/PATCH Requests

PATCH requests will return `HTTP 204` and per the spec, not include a body in the response.

In some cases where some condition for updating is not satisfied, a `HTTP 412` will be used.

#### DELETE Requests

DELETE requests will return `HTTP 204` and per the spec, not include a body in the response.

#### Error States

Errors will always return a message body with a status and description of the error. The response
will look similar to this:

```javascript
{
  "errors": {
    "message": "Permission denied",
    "status": 403
  }
}
```

Standard errors include:

* `Unauthenticated`: Missing the authentication header - `HTTP 401`
* `Unauthorized`: Bad credentials/auth token - `HTTP 403`
* `Resource not found`: Resource (or subresource) not found - `HTTP 404`

There is one special case for error checking. When validation fails during a `POST/PUT/PATCH` call,
a `HTTP 422` is returned with the errors containing the validations that failed. For example:

```javascript
{
  "errors": {
    "field_name": ["error message 1", "error message 2"]
  }
}
```

### Always Use Standard UTC Timestamps

This API accepts and returns times in UTC format only. Rendered times will be in ISO8601 format. For
example: `2014-01-01T13:00:00Z`.

## Development Details

### Ruby version

Tested against Ruby 2.1.2

### Configuration

* Initial setup: `bin/setup`
* Alter _config/database.yml_ and _config/application.yml_ as necessary

### How to run the test suite

* Run all tests: `rake`
* Run single test file: `spring testunit <file>`
* Run single test: `spring testunit <file> -n "<test_name>"`

### Deployment instructions

`git push production master`
