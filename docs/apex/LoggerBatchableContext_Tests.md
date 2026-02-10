---
hide:
  - path
---

# LoggerBatchableContext_Tests Class

`SUPPRESSWARNINGS`
`ISTEST`

## Class Diagram

```mermaid
graph TD
  LoggerBatchableContext_Tests["LoggerBatchableContext_Tests"]:::mainApexClass
  click LoggerBatchableContext_Tests "/objects/LoggerBatchableContext_Tests/"
  Entry["Entry"]:::apexClass
  click Entry "/apex/Entry/"
  Logger["Logger"]:::apexClass
  LoggerBatchableContext["LoggerBatchableContext"]:::apexClass
  LoggerConfigurationSelector["LoggerConfigurationSelector"]:::apexTestClass
  LoggerMockDataCreator["LoggerMockDataCreator"]:::apexTestClass

  LoggerBatchableContext_Tests --> Entry
  LoggerBatchableContext_Tests --> Logger
  LoggerBatchableContext_Tests --> LoggerBatchableContext
  LoggerBatchableContext_Tests --> LoggerConfigurationSelector
  LoggerBatchableContext_Tests --> LoggerMockDataCreator


  Logger --> Entry
  LoggerBatchableContext --> Logger
  LoggerConfigurationSelector --> Entry
  LoggerConfigurationSelector --> Logger
  LoggerMockDataCreator --> Logger

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1,2,3,4 stroke:#4C9F70,stroke-width:4px;
linkStyle 5,6,7,8,9 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
//------------------------------------------------------------------------------------------------//
// This file is part of the Nebula Logger project, released under the MIT License.                //
// See LICENSE file or go to https://github.com/jongpie/NebulaLogger for full license details.    //
//------------------------------------------------------------------------------------------------//

@SuppressWarnings('PMD.MethodNamingConventions')
@IsTest(IsParallel=true)
private class LoggerBatchableContext_Tests {
  static {
    // Don't use the org's actual custom metadata records when running tests
    LoggerConfigurationSelector.useMocks();
  }

  @IsTest
  static void it_constructs_instance_when_both_parameters_provided() {
    Database.BatchableContext mockBatchableContext = new LoggerMockDataCreator.MockBatchableContext();
    Schema.SObjectType sobjectType = Schema.LogEntryEvent__e.SObjectType;

    LoggerBatchableContext context = new LoggerBatchableContext(mockBatchableContext, sobjectType);

    System.Assert.areEqual(mockBatchableContext, context.batchableContext);
    System.Assert.areEqual(sobjectType, context.sobjectType);
    System.Assert.areEqual(sobjectType.toString(), context.sobjectTypeName);
  }

  @IsTest
  static void it_constructs_instance_when_neither_parameters_provided() {
    Database.BatchableContext nullBatchableContext = null;
    Schema.SObjectType nullSObjectType = null;

    LoggerBatchableContext context = new LoggerBatchableContext(nullBatchableContext, nullSObjectType);

    System.Assert.isNull(context.batchableContext);
    System.Assert.isNull(context.sobjectType);
    System.Assert.isNull(context.sobjectTypeName);
  }
}
```

## Methods
### `it_constructs_instance_when_both_parameters_provided()`

`ISTEST`

#### Signature
```apex
private static void it_constructs_instance_when_both_parameters_provided()
```

#### Return Type
**void**

---

### `it_constructs_instance_when_neither_parameters_provided()`

`ISTEST`

#### Signature
```apex
private static void it_constructs_instance_when_neither_parameters_provided()
```

#### Return Type
**void**