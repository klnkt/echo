# README

Echo is an API only app that allows users to create mock endpoints and access them via HTTP.

## Setup

### Dependencies
* ruby v3.2.1
* rails v.7.0.0+
* grape
* SQLite 3

### Start Echo
1. Run bundle
```
bundle install
```
2. Run migrations
```
bin/rails db:setup
```
3. Start the server
```
bundle exec rails s
```

### Run specs
```
bundle exec rspec ./spec
```

## Documentation
Follwing endpoints are available to list, create, update and delete mock endpoints.
### `GET /endpoints`
Lists all existing mock endpoints
```bash
curl --request GET \
  --url http://localhost:3000/endpoints
```
### `POST /endpoints` 
Creates a mock endpoint. Endpoints must have a unique verb + path combination. Returns created endpoint.

Accepts parameters:
* `verb` (required) - a string value that may take one of HTTP method name
* `path` (required) - a string value of the path part of URL, should start with /
* `response` (required) - an object with following attributes:
  * `code` (required) - an integer status code returned by Endpoint
    * only codes in the range 200 - 599 are accepted
  * `headers` (optional) - a key-value structure where keys represent HTTP header
  names and values hold actual values of these headers returned by Endpoint
  * `body` (optional) - a string representation of response body returned by
  Endpoint.
    * If valid JSON string is provided, mock endpoint will return a JSON instead of string.
```bash
curl --request POST \
  --url http://localhost:3000/endpoints/ \
  --header 'Content-Type: application/json' \
  --data '{
	"verb": "delete",
	"path": "/foo/bar",
	"response": {
		"code": 599,
		"headers": {
			"Cookie": "1234"
		},
		"body": "baz"
	}
}'
```

### `PATCH /endpoints/:id`
Updates a mock endpoint. Accepted parameters are the same as in POST request. Returns updated endpoint.

If endpoint does not exist, returns `404 Not Found error`.

```bash
curl --request PATCH \
  --url http://localhost:3000/endpoints/1 \
  --header 'Content-Type: application/json' \
  --data '{
	"verb": "post",
	"path": "/foo/bar",
	"response": {
		"code": 599,
		"headers": {
			"Cookie": "1234"
		},
		"body": "baz"
	}
}'
```
### `DELETE /endpoints/:id`
Deletes a mock endpoint.

If endpoint does not exist, returns `404 Not Found error`.

```bash 
curl --request DELETE \
  --url http://localhost:3000/endpoints/1
```

### Calling mock endpoints
After creating a mock endpoint with following params:
```bash
curl --request POST \
  --url http://localhost:3000/endpoints/ \
  --header 'Content-Type: application/json' \
  --data '{
	"verb": "delete",
	"path": "/foo/bar",
	"response": {
		"code": 599,
		"headers": {
			"Cookie": "1234"
		},
		"body": "baz"
	}
}'
```

It an be called via:
```bash
curl --request DELETE \
  --url http://localhost:3000/foo/bar
```
