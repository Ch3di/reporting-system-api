# Delete a Report's Category

    DELETE categories/:id

## Description

remove an existing report's category

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
  --url http://127.0.0.1:8080/categories/B8D6F198-A2B0-4AB1-9E75-9CB1D3FDC219
```

**Return Body**

- No body returned for the response

**Return Code**

- **204**
