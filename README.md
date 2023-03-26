# README

Echo is a n API only app that allows users create mock endpoints and access them via HTTP.

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
Creates a mock endpoint. Endpoints must have a unique verb + path combination.

If endpoint does not exist, returns `404 Not Found error`.

Accepts parameters:
* `verb` (required) - a string value that may take one of HTTP method name. Available verbs are:
  * get
  * post
  * patch
  * delete
* `path` (required) - a string value of the path part of URL, should start from /
* `response` (required) - an object with following attributes:
  * `code` (required) - an integer status code returned by Endpoint
    * only codes in the range 101 - 599 are accepted
  * `headers` (optional) - a key-value structure where keys represent HTTP header
  names and values hold actual values of these headers returned by Endpoint
    * invalid headers will be ignored
  * `body` (optional) - a string representation of response body returned by
  Endpoint.
    * If valid JSON string is provided, mock endpoint will return a JSON isneatfd of string.
```bash
curl --request POST \
  --url http://localhost:3000/endpoints/ \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data verb=delete \
  --data path=/foo/bar \
  --data 'response[code]=599' \
  --data 'response[body]=baz' \
  --data 'response[headers][Cookie]=1234'
```

### `PATCH /endpoints/:id`
Updates a mock endpoint. Accepted parameters are the same as in POST request.

If endpoint does not exist, returns `404 Not Found error`.

```bash
curl --request PATCH \
  --url http://localhost:3000/endpoints/1 \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data verb=delete \
  --data path=/foo/bar/baz \
  --data 'response[code]=453' \
  --data 'response[body]={"message": "Hello, world"}' \
  --data 'response[headers][Cookie]=123'
```
### `DELETE /endpoints/:id`
Deletes a mock endpoint and returns ID of deleted endpioint.

If endpoint does not exist, returns `404 Not Found error`.

```bash 
curl --request DELETE \
  --url http://localhost:3000/endpoints/1
```

### Calling mock endpoiints
After creating a mock end point with following params:
```bash
curl --request POST \
  --url http://localhost:3000/endpoints/ \
  --header 'Content-Type: application/x-www-form-urlencoded' \
  --data verb=delete \
  --data path=/foo/bar \
  --data 'response[code]=599' \
  --data 'response[body]=baz' \
  --data 'response[headers][Cookie]=1234'
```

It an be called via:
```bash
curl --request DELETE \
  --url http://localhost:3000/foo/bar
```
