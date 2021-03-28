# Get the Report's Categories

    GET /reports/:report-id/categories

## Description

Get all the report's categories of a spacific report using its ID

## Requires authentication

**No Authentication is required**

## Parameters

- **report-id** : required (type:UUID)

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
  --url http://127.0.0.1:8080/reports/C4421084-FC77-419A-9779-129928ECC728/categories
```

**Return Body**

```json
[
  {
    "description": "personal attacks often involve someone making damaging remarks relating to somebody’s lifestyle or choices. These types of attack can include comments that question a person’s intelligence, values, integrity, motivations or decisions.",
    "name": "personal attack",
    "id": "77A014A1-2EBE-4109-A228-FBD3B7013907"
  },
  {
    "id": "6E9615B3-3585-4BF1-BA3A-20341BA924A4",
    "name": "sexism",
    "description": "prejudice or discrimination based on sex or gender"
  }
]
```

**Return Code**

- **200**
