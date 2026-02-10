---
hide:
  - path
---

# MockDmlOperator Class

**Implements**

[IDmlOperator](IDmlOperator.md)

## Class Diagram

```mermaid
graph TD
  MockDmlOperator["MockDmlOperator"]:::mainApexClass
  click MockDmlOperator "/objects/MockDmlOperator/"
  DmlOperator["DmlOperator"]:::apexClass
  click DmlOperator "/apex/DmlOperator/"
  IDmlOperator["IDmlOperator"]:::apexClass
  click IDmlOperator "/apex/IDmlOperator/"
  MockDmlOperatorTest["MockDmlOperatorTest"]:::apexTestClass
  click MockDmlOperatorTest "/apex/MockDmlOperatorTest/"
  SOrchestratorTest["SOrchestratorTest"]:::apexTestClass
  click SOrchestratorTest "/apex/SOrchestratorTest/"

  MockDmlOperator --> DmlOperator
  MockDmlOperator --> IDmlOperator

  MockDmlOperatorTest --> MockDmlOperator
  SOrchestratorTest --> MockDmlOperator

  DmlOperator --> IDmlOperator
  IDmlOperator --> DmlOperator
  MockDmlOperatorTest --> DmlOperator
  SOrchestratorTest --> DmlOperator

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1 stroke:#4C9F70,stroke-width:4px;
linkStyle 2,3 stroke:#FF8C00,stroke-width:2px;
linkStyle 4,5,6,7 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
public with sharing class MockDmlOperator implements IDmlOperator {
  private Integer insertCount;

  public MockDmlOperator() {
    this.insertCount = 0;
  }

  public void doInsert(List<SObject> records){
    System.debug('Mock inserting ' + records.size() + ' records.');
    for(SObject record : records){
      record.Id = genereteId(record);
    }
  }
  public void doUpdate(List<SObject> records){
    // do nothing
  }
  public void doDelete(List<SObject> records) {
    // do nothing
  }

  /**
   * generate a mock Id for the record
   *
   * @param record SObject to be inserted
   * @return generated Id
   */
  private String genereteId(SObject record) {
    String prefix = record.getSObjectType().getDescribe().getKeyPrefix();
    String generatedId = prefix + String.valueOf(this.insertCount).leftPad(12, '0');
    this.insertCount++;
    return generatedId;
  }
}
```

## Fields
### `insertCount`

#### Signature
```apex
private insertCount
```

#### Type
Integer

## Constructors
### `MockDmlOperator()`

#### Signature
```apex
public MockDmlOperator()
```

## Methods
### `doInsert(records)`

#### Signature
```apex
public void doInsert(List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| records | List<SObject> |  |

#### Return Type
**void**

---

### `doUpdate(records)`

#### Signature
```apex
public void doUpdate(List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| records | List<SObject> |  |

#### Return Type
**void**

---

### `doDelete(records)`

#### Signature
```apex
public void doDelete(List<SObject> records)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| records | List<SObject> |  |

#### Return Type
**void**

---

### `genereteId(record)`

generate a mock Id for the record

#### Signature
```apex
private String genereteId(SObject record)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| record | SObject | SObject to be inserted |

#### Return Type
**String**

generated Id