# Delete a User

    DELETE users/:id

## Description

remove a registered user

## Requires authentication

**Bearer Authentication is required**

## Parameters

- **id** : required (type:UUID)

## Return format

     JSON or empty body

## Errors

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
curl --request DELETE \
  --url http://127.0.0.1:8080/users/85368273-6566-45C8-B4AF-AE09274C123A
```

**Return Body**

- No body returned for the response

**Return Code**

- **200**
