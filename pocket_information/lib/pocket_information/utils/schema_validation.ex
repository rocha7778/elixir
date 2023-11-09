defmodule PocketInformation.Utils.SchemaValidation do
  @doc """
  validates our input
  """
  require Exonerate

  Exonerate.function_from_string(:def, :validate_retrieve_pocket_payload, """
  {
    "$schema": "http://json-schema.org/draft-04/schema#",
    "title": "Cuenta",
    "description": "Representa la cuenta a consultar",
    "type": "object",
    "required": ["data"],
    "properties": {
        "data": {
            "type": "array",
            "items": {
                "type": "object",
                "required":["account"],
                "properties": {
                    "account" :{
                        "$ref" : "#/definitions/account"
                    }
                }
            },
            "minItems": 1,
            "maxItems": 1
        }
    },
    "definitions": {
        "account": {
            "type": "object",
            "required": [
                "type",
                "number",
                "pocket"
            ],
            "properties": {
                "type": {
                    "type": "string",
                    "description": "Tipo de cuenta dueña del bolsillo. indica si es ahorro o corriente",
                    "example": "CUENTA_DE_AHORRO"
                },
                "number": {
                    "type": "string",
                    "description": "Número de cuenta.",
                    "example": "91200244139",
                    "maxLength": 16,
                    "minLength" : 1
                },
                "pocket" :{
                    "type":"object",
                    "required":["number"],
                    "properties": {
                        "number": {
                            "type" : "string",
                            "description": "Numero de bolsillo",
                            "example": "00000004067247390011",
                            "minLength" : 1,
                            "maxLength": 20
                        }
                    }
                }
            }
        }
    }
  }
  """)
end
