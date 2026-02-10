---
hide:
  - path
---

# MockDmlOperatorTest Class

`ISTEST`

## Class Diagram

```mermaid
graph TD
  MockDmlOperatorTest["MockDmlOperatorTest"]:::mainApexClass
  click MockDmlOperatorTest "/objects/MockDmlOperatorTest/"
  DmlOperator["DmlOperator"]:::apexClass
  click DmlOperator "/apex/DmlOperator/"
  DmlOperatorTest["DmlOperatorTest"]:::apexTestClass
  click DmlOperatorTest "/apex/DmlOperatorTest/"
  MockDmlOperator["MockDmlOperator"]:::apexClass
  click MockDmlOperator "/apex/MockDmlOperator/"

  MockDmlOperatorTest --> DmlOperator
  MockDmlOperatorTest --> DmlOperatorTest
  MockDmlOperatorTest --> MockDmlOperator


  DmlOperatorTest --> DmlOperator
  MockDmlOperator --> DmlOperator

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1,2 stroke:#4C9F70,stroke-width:4px;
linkStyle 3,4 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
@isTest
public with sharing class MockDmlOperatorTest {
  @isTest
  static void testDoInsert_WhenExecute_ThenSuccess() {
    // Arrange
    List<Account> accList = new List<Account>{new Account(Name = 'Test Account')};

    // Act
    try {
      (new MockDmlOperator()).doInsert(accList);
    } catch (Exception e) {
      // Assert
      Assert.fail('例外が発生しました。' + e.getMessage());
    }

    // Assert
    Assert.isTrue(accList[0].Id != null, 'IDが設定されていることを確認');
  }
}
```

## Methods
### `testDoInsert_WhenExecute_ThenSuccess()`

`ISTEST`

#### Signature
```apex
private static void testDoInsert_WhenExecute_ThenSuccess()
```

#### Return Type
**void**