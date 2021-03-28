# Update a Report's Category

    PATCH /categories/:id

## Description

Update an existing report category

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
curl --request PATCH \
  --url http://127.0.0.1:8080/categories/6E9615B3-3585-4BF1-BA3A-20341BA924A4 \
  --header 'content-type: application/json' \
  --data '{
	"name": "sexism"
}'
```

**Return Body**

```json
{
  "description": "prejudice or discrimination based on sex or gender",
  "id": "6E9615B3-3585-4BF1-BA3A-20341BA924A4",
  "name": "sexism"
}
```

**Return Code**

- **200**
