---
hide:
  - path
---

# DmlOperatorTest Class

`ISTEST`

## Class Diagram

```mermaid
graph TD
  DmlOperatorTest["DmlOperatorTest"]:::mainApexClass
  click DmlOperatorTest "/objects/DmlOperatorTest/"
  DmlOperator["DmlOperator"]:::apexClass
  click DmlOperator "/apex/DmlOperator/"
  MockDmlOperatorTest["MockDmlOperatorTest"]:::apexTestClass
  click MockDmlOperatorTest "/apex/MockDmlOperatorTest/"

  DmlOperatorTest --> DmlOperator

  MockDmlOperatorTest --> DmlOperatorTest

  MockDmlOperatorTest --> DmlOperator

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0 stroke:#4C9F70,stroke-width:4px;
linkStyle 1 stroke:#FF8C00,stroke-width:2px;
linkStyle 2 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
@isTest
public with sharing class DmlOperatorTest {
  @isTest
  static void testDoInsertUpdateDelete_WhenExecute_ThenSuccess() {
    // Arrange
    List<Account> accList = new List<Account>{new Account(Name = 'Test Account')};
    DmlOperator dmlOperator = new DmlOperator();

    // Act
    try {
      dmlOperator.doInsert(accList);
      accList[0].Name = 'Updated Account';
      dmlOperator.doUpdate(accList);
      dmlOperator.doDelete(accList);
    } catch (Exception e) {
      // Assert
      Assert.fail('例外が発生しました。' + e.getMessage());
    }
  }
}
```

## Methods
### `testDoInsertUpdateDelete_WhenExecute_ThenSuccess()`

`ISTEST`

#### Signature
```apex
private static void testDoInsertUpdateDelete_WhenExecute_ThenSuccess()
```

#### Return Type
**void**