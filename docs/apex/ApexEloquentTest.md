---
hide:
  - path
---

# ApexEloquentTest Class

`ISTEST`

## Class Diagram

```mermaid
graph TD
  ApexEloquentTest["ApexEloquentTest"]:::mainApexClass
  click ApexEloquentTest "/objects/ApexEloquentTest/"
  Eloquent["Eloquent"]:::apexClass
  click Eloquent "/apex/Eloquent/"
  EloquentTest["EloquentTest"]:::apexTestClass
  click EloquentTest "/apex/EloquentTest/"
  Scribe["Scribe"]:::apexClass
  click Scribe "/apex/Scribe/"

  ApexEloquentTest --> Eloquent
  ApexEloquentTest --> EloquentTest
  ApexEloquentTest --> Scribe


  Eloquent --> Scribe
  EloquentTest --> Eloquent
  EloquentTest --> Scribe
  Scribe --> Eloquent

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1,2 stroke:#4C9F70,stroke-width:4px;
linkStyle 3,4,5,6 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
@IsTest
private class ApexEloquentTest {
    @IsTest
    static void testBasicQuery() {
        // Arrange
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        // Act
        Scribe scribe = Scribe.source(Account.SObjectType)
            .fields(new List<String>{'Id', 'Name'})
            .whereEqual('Name', 'Test Account');
        
        List<Account> results = (List<Account>) new Eloquent().getAsSObject(scribe);

        // Assert
        Assert.areEqual(1, results.size(), 'Should find one account');
        Assert.areEqual('Test Account', results[0].Name, 'Name should match');
    }
}
```

## Methods
### `testBasicQuery()`

`ISTEST`

#### Signature
```apex
private static void testBasicQuery()
```

#### Return Type
**void**