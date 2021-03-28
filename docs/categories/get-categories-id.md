# Get a Category

    GET /categories/:id

## Description

Get a report category using its ID

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
  --url http://127.0.0.1:8080/categories/403103E1-9412-4B48-A261-F2115F4AB131
```

**Return Body**

```json
{
  "description": "deceive and defraud people",
  "name": "scams",
  "id": "403103E1-9412-4B48-A261-F2115F4AB131"
}
```

**Return Code**

- **200**
