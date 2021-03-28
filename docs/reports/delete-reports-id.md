# Delete a Report

    DELETE reports/:id

## Description

remove an existing report

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
  --url http://127.0.0.1:8080/reports/EBF1501A-0B6E-4637-88FB-7E23637C3A1C
```

**Return Body**

- No body returned for the response

**Return Code**

- **204**
