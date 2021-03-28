# Get a User

    GET /users/:id

## Description

Get a user using their ID

## Requires authentication

**No Authentication is required**

## Parameters

- **id** : required (type:UUID)

## Return format

     JSON

## Errors

- **UnknownError (code:500)** : this occurs when an unknown error occurred on the server side.

- **Bad Request (code:400)** : this occur when a non v4 UUID was provided in the URI.

```json
{
  "reason": "Bad Request",
  "error": true
}
```

- **Not Found (code:404)** : this occur when a non v4 UUID was provided in the URI.

```json
{
  "reason": "Not Found",
  "error": true
}
```

## Example

**Request**

```bash
curl --request GET \
  --url http://127.0.0.1:8080/users/B641C465-B006-46D8-9B8B-1FA33E68D4AC
```

**Return Body**

```json
{
  "id": "B641C465-B006-46D8-9B8B-1FA33E68D4AC",
  "name": "Hisoka"
}
```

**Return Code**

- **200**
