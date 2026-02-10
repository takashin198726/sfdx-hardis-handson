---
hide:
  - path
---

# LogEntryEventStreamController_Tests Class

`SUPPRESSWARNINGS`
`ISTEST`

## Class Diagram

```mermaid
graph TD
  LogEntryEventStreamController_Tests["LogEntryEventStreamController_Tests"]:::mainApexClass
  click LogEntryEventStreamController_Tests "/objects/LogEntryEventStreamController_Tests/"
  Entry["Entry"]:::apexClass
  click Entry "/apex/Entry/"
  LogEntryEventStreamController["LogEntryEventStreamController"]:::apexClass
  Logger["Logger"]:::apexClass
  LoggerConfigurationSelector["LoggerConfigurationSelector"]:::apexTestClass
  LoggerParameter["LoggerParameter"]:::apexClass
  LoggerTestConfigurator["LoggerTestConfigurator"]:::apexTestClass

  LogEntryEventStreamController_Tests --> Entry
  LogEntryEventStreamController_Tests --> LogEntryEventStreamController
  LogEntryEventStreamController_Tests --> Logger
  LogEntryEventStreamController_Tests --> LoggerConfigurationSelector
  LogEntryEventStreamController_Tests --> LoggerParameter
  LogEntryEventStreamController_Tests --> LoggerTestConfigurator


  LogEntryEventStreamController --> Entry
  LogEntryEventStreamController --> Logger
  LogEntryEventStreamController --> LoggerParameter
  Logger --> Entry
  Logger --> LoggerParameter
  LoggerConfigurationSelector --> Entry
  LoggerConfigurationSelector --> Logger
  LoggerConfigurationSelector --> LoggerParameter
  LoggerParameter --> Entry
  LoggerParameter --> Logger
  LoggerParameter --> LoggerConfigurationSelector
  LoggerTestConfigurator --> Entry
  LoggerTestConfigurator --> Logger
  LoggerTestConfigurator --> LoggerParameter

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1,2,3,4,5 stroke:#4C9F70,stroke-width:4px;
linkStyle 6,7,8,9,10,11,12,13,14,15,16,17,18,19 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
//------------------------------------------------------------------------------------------------//
// This file is part of the Nebula Logger project, released under the MIT License.                //
// See LICENSE file or go to https://github.com/jongpie/NebulaLogger for full license details.    //
//------------------------------------------------------------------------------------------------//

@SuppressWarnings('PMD.ApexDoc, PMD.CyclomaticComplexity, PMD.ExcessiveParameterList, PMD.MethodNamingConventions, PMD.NcssMethodCount')
@IsTest
private class LogEntryEventStreamController_Tests {
  static {
    // Don't use the org's actual custom metadata records when running tests
    LoggerConfigurationSelector.useMocks();
  }

  @IsTest
  static void it_should_return_is_enabled_parameter() {
    Boolean mockValue = false;
    LoggerParameter__mdt mockParameter = new LoggerParameter__mdt(DeveloperName = 'EnableLogEntryEventStream', Value__c = System.JSON.serialize(mockValue));
    LoggerParameter.setMock(mockParameter);

    Boolean returnedValue = LogEntryEventStreamController.isEnabled();

    System.Assert.areEqual(mockValue, returnedValue);
  }

  @IsTest
  static void it_should_return_list_of_fields_configured_in_logger_parameters() {
    String fields = '["Timestamp__c", "LoggedByUsername__c", "OriginLocation__c"]';
    LoggerTestConfigurator.setMock(new LoggerParameter__mdt(DeveloperName = LogEntryEventStreamController.DISPLAY_FIELDS_PARAMETER_NAME, Value__c = fields));
    List<String> mockDisplayFields = (List<String>) System.JSON.deserialize(fields, List<String>.class);
    List<String> displayFields = LogEntryEventStreamController.getDatatableDisplayFields();

    System.Assert.areEqual(mockDisplayFields.size(), displayFields.size(), 'fields count mismatch');
    for (String fieldName : mockDisplayFields) {
      System.Assert.areEqual(true, displayFields.contains(fieldName), 'field not found: ' + fieldName);
    }
  }

  @IsTest
  static void it_should_return_default_fields_when_list_of_fields_not_configured_in_logger_parameters() {
    List<String> displayFields = LogEntryEventStreamController.getDatatableDisplayFields();

    System.Assert.areEqual(LogEntryEventStreamController.DEFAULT_DISPLAY_FIELDS.size(), displayFields.size(), 'fields count mismatch');
    for (String fieldName : LogEntryEventStreamController.DEFAULT_DISPLAY_FIELDS) {
      System.Assert.isTrue(displayFields.contains(fieldName), 'field not found: ' + fieldName);
    }
  }
}
```

## Methods
### `it_should_return_is_enabled_parameter()`

`ISTEST`

#### Signature
```apex
private static void it_should_return_is_enabled_parameter()
```

#### Return Type
**void**

---

### `it_should_return_list_of_fields_configured_in_logger_parameters()`

`ISTEST`

#### Signature
```apex
private static void it_should_return_list_of_fields_configured_in_logger_parameters()
```

#### Return Type
**void**

---

### `it_should_return_default_fields_when_list_of_fields_not_configured_in_logger_parameters()`

`ISTEST`

#### Signature
```apex
private static void it_should_return_default_fields_when_list_of_fields_not_configured_in_logger_parameters()
```

#### Return Type
**void**