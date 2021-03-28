# Get all the registered users

    GET /users

## Description

Reads the list of all the users

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
curl --request GET \
  --url http://127.0.0.1:8080/users
```

**Return Body**

```json
[
  {
    "name": "Ch",
    "id": "7883DF82-5C02-41E9-89C1-1572BCF7765D"
  }
]
```

**Return Code**

- **200**
