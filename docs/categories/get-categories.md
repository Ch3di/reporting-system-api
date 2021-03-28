# Get The Categories

    GET /categories

## Description

Reads the list of all available report categories.

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
  --url http://127.0.0.1:8080/categories
```

**Return Body**

```json
[
  {
    "description": "deceive and defraud people",
    "name": "scams",
    "id": "403103E1-9412-4B48-A261-F2115F4AB131"
  }
]
```

**Return Code**

- **200**
