#Author: dmarriet@bancolombia.com.co

Feature: Get the pocket information
  As a Bancolombia user
  I want to check the pocket information

  Background:
    * def endpoint = endpoint
    * def sslJSONe = sslJSON

  Scenario Outline: Check pocket information
    * configure headers = {'x-ibm-client-id':'12312321','x-ibm-client-secret':'545454545','message-id':'343434343434'}
    * configure ssl = sslJSONe
    * header Authorization = encodedi
    Given url endpoint
    And request {"data":[{"account":{"type":"CUENTA_DE_AHORRO","number":<accountNumber>,"pocket":{"number":<pocketNumber>}}}]}
    When method POST
    Then status 200
    Examples:
      | accountNumber | pocketNumber |
      | "91200244139" | "912002441391" |

  Scenario Outline: Check the pocket information with an invalid pocket number
    * configure headers = {'x-ibm-client-id':'12312321','x-ibm-client-secret':'545454545','message-id':'343434343434'}
    * configure ssl = sslJSONe
    * header Authorization = encodedi
    Given url endpoint
    And request {"data":[{"account":{"type":"CUENTA_DE_AHORRO","number":<accountNumber>,"pocket":{"number":<pocketNumber>}}}]}
    When method POST
    Then status 400
    And match response contains { "title": "Error on request"}
    Examples:
      | accountNumber | pocketNumber |
      | "91200244139" | "12345672456" |

  Scenario Outline: Check the pocket information with an invalid account number
    * configure headers = {'x-ibm-client-id':'12312321','x-ibm-client-secret':'545454545','message-id':'343434343434'}
    * configure ssl = sslJSONe
    * header Authorization = encodedi
    Given url endpoint
    And request {"data":[{"account":{"type":"CUENTA_DE_AHORRO","number":<accountNumber>,"pocket":{"number":<pocketNumber>}}}]}
    When method POST
    Then status 400
    And match response contains { "title": "Error on request"}
    Examples:
      | accountNumber | pocketNumber |
      | "1230000000000000000000000000000000000" | "12345672456" |