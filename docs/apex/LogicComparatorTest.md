---
hide:
  - path
---

# LogicComparatorTest Class

`ISTEST`

## Class Diagram

```mermaid
graph TD
  LogicComparatorTest["LogicComparatorTest"]:::mainApexClass
  click LogicComparatorTest "/objects/LogicComparatorTest/"
  LogicComparator["LogicComparator"]:::apexClass
  click LogicComparator "/apex/LogicComparator/"

  LogicComparatorTest --> LogicComparator



classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0 stroke:#4C9F70,stroke-width:4px;
```

<!-- Apex description -->

## Apex Code

```java
@IsTest
private class LogicComparatorTest {
    
    // Mock Logic implementation for testing
    class InsertAccountLogic implements LogicComparator.ILogic {
        private String name;
        public InsertAccountLogic(String name) {
            this.name = name;
        }
        public void run() {
            insert new Account(Name = this.name);
        }
    }
    
    // Mock Result Provider
    class AccountResultProvider implements LogicComparator.IResultProvider {
        public List<SObject> getResults() {
            return [SELECT Name FROM Account ORDER BY CreatedDate DESC LIMIT 1];
        }
    }
    
    @IsTest
    static void testCompareMatchingLogic() {
        LogicComparator.ILogic logic1 = new InsertAccountLogic('Test Account');
        LogicComparator.ILogic logic2 = new InsertAccountLogic('Test Account');
        LogicComparator.IResultProvider provider = new AccountResultProvider();
        
        Test.startTest();
        // Should not throw exception
        LogicComparator.compare(logic1, logic2, provider);
        Test.stopTest();
    }
    
    @IsTest
    static void testCompareMismatchingLogic() {
        LogicComparator.ILogic logic1 = new InsertAccountLogic('Test Account A');
        LogicComparator.ILogic logic2 = new InsertAccountLogic('Test Account B');
        LogicComparator.IResultProvider provider = new AccountResultProvider();
        
        Test.startTest();
        try {
            LogicComparator.compare(logic1, logic2, provider);
            Assert.fail('Should have thrown an exception due to mismatch');
        } catch (LogicComparator.LogicComparatorException e) {
            // Expected
        }
        Test.stopTest();
    }
}
```

## Methods
### `testCompareMatchingLogic()`

`ISTEST`

#### Signature
```apex
private static void testCompareMatchingLogic()
```

#### Return Type
**void**

---

### `testCompareMismatchingLogic()`

`ISTEST`

#### Signature
```apex
private static void testCompareMismatchingLogic()
```

#### Return Type
**void**

## Classes
### InsertAccountLogic Class

**Implements**

LogicComparator.ILogic

#### Fields
##### `name`

###### Signature
```apex
private name
```

###### Type
String

#### Constructors
##### `InsertAccountLogic(name)`

###### Signature
```apex
public InsertAccountLogic(String name)
```

###### Parameters
| Name | Type | Description |
|------|------|-------------|
| name | String |  |

#### Methods
##### `run()`

###### Signature
```apex
public void run()
```

###### Return Type
**void**

### AccountResultProvider Class

**Implements**

LogicComparator.IResultProvider

#### Methods
##### `getResults()`

###### Signature
```apex
public List<SObject> getResults()
```

###### Return Type
**List<SObject>**