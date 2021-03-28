# Get the Reports of a Category

    GET /categories/:category-id/reports

## Description

Get all the reports that belong to a specific category using its ID

## Requires authentication

**No Authentication is required**

## Parameters

- **category-id** : required (type:UUID)

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
  --url http://127.0.0.1:8080/categories/77A014A1-2EBE-4109-A228-FBD3B7013907/reports
```

**Return Body**

```json
[
  [
    {
      "details": "testing the report functionality",
      "reportID": "C4421084-FC77-419A-9779-129928ECC728",
      "reportedID": "7883DF82-5C02-41E9-89C1-1572BCF7765D",
      "reporterID": "0A8AE278-1D7B-4D15-A802-96F249C1CE4A"
    }
  ]
]
```

**Return Code**

- **200**
