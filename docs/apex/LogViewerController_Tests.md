---
hide:
  - path
---

# LogViewerController_Tests Class

`SUPPRESSWARNINGS`
`ISTEST`

## Class Diagram

```mermaid
graph TD
  LogViewerController_Tests["LogViewerController_Tests"]:::mainApexClass
  click LogViewerController_Tests "/objects/LogViewerController_Tests/"
  Entry["Entry"]:::apexClass
  click Entry "/apex/Entry/"
  Logger["Logger"]:::apexClass
  LoggerConfigurationSelector["LoggerConfigurationSelector"]:::apexTestClass
  LoggerSObjectHandler["LoggerSObjectHandler"]:::apexClass
  LogViewerController["LogViewerController"]:::apexClass

  LogViewerController_Tests --> Entry
  LogViewerController_Tests --> Logger
  LogViewerController_Tests --> LoggerConfigurationSelector
  LogViewerController_Tests --> LoggerSObjectHandler
  LogViewerController_Tests --> LogViewerController


  Logger --> Entry
  Logger --> LoggerSObjectHandler
  LoggerConfigurationSelector --> Entry
  LoggerConfigurationSelector --> Logger
  LoggerConfigurationSelector --> LoggerSObjectHandler
  LoggerSObjectHandler --> Entry
  LoggerSObjectHandler --> Logger
  LoggerSObjectHandler --> LoggerConfigurationSelector
  LogViewerController --> Entry
  LogViewerController --> Logger

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1,2,3,4 stroke:#4C9F70,stroke-width:4px;
linkStyle 5,6,7,8,9,10,11,12,13,14 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
//------------------------------------------------------------------------------------------------//
// This file is part of the Nebula Logger project, released under the MIT License.                //
// See LICENSE file or go to https://github.com/jongpie/NebulaLogger for full license details.    //
//------------------------------------------------------------------------------------------------//

@SuppressWarnings('PMD.ApexDoc, PMD.MethodNamingConventions')
@IsTest(IsParallel=true)
private class LogViewerController_Tests {
  static {
    // Don't use the org's actual custom metadata records when running tests
    LoggerConfigurationSelector.useMocks();
  }

  @TestSetup
  static void setupData() {
    LoggerSObjectHandler.shouldExecute(false);
    Log__c log = new Log__c(TransactionId__c = '1234');
    insert log;
    List<LogEntry__c> logEntries = new List<LogEntry__c>();
    for (Integer i = 0; i < 5; i++) {
      logEntries.add(new LogEntry__c(Log__c = log.Id, Message__c = 'some message, number ' + i));
    }
    insert logEntries;
  }

  @IsTest
  static void it_should_return_log_when_id_provided() {
    Log__c log = [SELECT Id, TransactionId__c FROM Log__c];
    Map<Id, LogEntry__c> logEntryIdToLogEntry = new Map<Id, LogEntry__c>([SELECT Id FROM LogEntry__c]);

    LogViewerController.LogDTO returnedLogDto = LogViewerController.getLog(log.Id);

    System.Assert.areEqual(log.Id, returnedLogDto.log.Id);
    System.Assert.areEqual(logEntryIdToLogEntry.size(), returnedLogDto.logEntries.size());
    String className = LogViewerController_Tests.class.getName();
    String namespacePrefix = className.contains('.') ? className.substringBefore('.') + '__' : '';
    System.Assert.areEqual(namespacePrefix + 'LogEntries__r', returnedLogDto.logEntriesRelationshipName);
    for (LogEntry__c logEntry : returnedLogDto.logEntries) {
      System.Assert.isTrue(logEntryIdToLogEntry.containsKey(logEntry.Id));
      System.Assert.areEqual(log.Id, logEntry.Log__c);
    }
  }
}
```

## Methods
### `setupData()`

`TESTSETUP`

#### Signature
```apex
private static void setupData()
```

#### Return Type
**void**

---

### `it_should_return_log_when_id_provided()`

`ISTEST`

#### Signature
```apex
private static void it_should_return_log_when_id_provided()
```

#### Return Type
**void**