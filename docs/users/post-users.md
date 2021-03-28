# Register a User

    POST /users

## Description

Registers a new user

## Requires authentication

**No Authentication is required**

## Parameters

**No Parameters are required**

## Return format

     JSON

## Errors

- **UnknownError (code:500)** : this occurs when an unknown error occurred on the server side.

## Example

**Request**

```bash
curl --request POST \
  --url http://127.0.0.1:8080/users \
  --header 'content-type: application/json' \
  --data '{
	"name": "Ch3di"
}'
```

**Return Body**

```json
{
  "id": "7685C4D7-C7FB-4E91-95D3-15E8EAD433ED",
  "name": "Ch3di"
}
```

**Return Code**

- **200**
