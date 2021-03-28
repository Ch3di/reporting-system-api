# Create a Report

    POST /reports

## Description

Generate new report

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
  --url http://127.0.0.1:8080/reports \
  --header 'content-type: application/json' \
  --data '{
	"details": "testing the report functionality :p",
	"reporter": "7883DF82-5C02-41E9-89C1-1572BCF7765D",
	"reported": "0A8AE278-1D7B-4D15-A802-96F249C1CE4A",
	"categoryIDs": [
		"A8BE6E21-4297-4DB0-AB2D-A4E74D395A6D",
		"77A014A1-2EBE-4109-A228-FBD3B7013907"
	]
}'
```

**Return Body**

```json
{
  "reportID": "1E6AF9A4-8CBD-4FE1-9A0D-77D70B6C6E9F",
  "reporterID": "7883DF82-5C02-41E9-89C1-1572BCF7765D",
  "reportedID": "0A8AE278-1D7B-4D15-A802-96F249C1CE4A",
  "details": "testing the report functionality :p"
}
```

**Return Code**

- **200**
