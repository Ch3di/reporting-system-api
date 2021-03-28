# Create a Report Category

    POST /categories

## Description

Create a new report category

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
curl --request POST \
  --url http://127.0.0.1:8080/categories \
  --header 'content-type: application/json' \
  --data '{
	"name": "fake profile",
	"description": "A fake profile is the representation of a person, organization or company that does not truly exist, on social media. Often these accounts use names and identities that not only look real but are designed to get closer access to specific people and their target audience."
}'
```

**Return Body**

```json
{
  "name": "fake profile",
  "id": "CF4BD8F9-1579-46C9-9C11-027CF534EA4B",
  "description": "A fake profile is the representation of a person, organization or company that does not truly exist, on social media. Often these accounts use names and identities that not only look real but are designed to get closer access to specific people and their target audience."
}
```

**Return Code**

- **200**
