---
hide:
  - path
---

# DmlOperator Class

**Implements**

[IDmlOperator](IDmlOperator.md)

## Class Diagram

```mermaid
graph TD
  DmlOperator["DmlOperator"]:::mainApexClass
  click DmlOperator "/objects/DmlOperator/"
  IDmlOperator["IDmlOperator"]:::apexClass
  click IDmlOperator "/apex/IDmlOperator/"
  DmlOperatorTest["DmlOperatorTest"]:::apexTestClass
  click DmlOperatorTest "/apex/DmlOperatorTest/"
  MockDmlOperator["MockDmlOperator"]:::apexClass
  click MockDmlOperator "/apex/MockDmlOperator/"
  MockDmlOperatorTest["MockDmlOperatorTest"]:::apexTestClass
  click MockDmlOperatorTest "/apex/MockDmlOperatorTest/"
  SOrchestrator["SOrchestrator"]:::apexClass
  click SOrchestrator "/apex/SOrchestrator/"
  SOrchestratorTest["SOrchestratorTest"]:::apexTestClass
  click SOrchestratorTest "/apex/SOrchestratorTest/"

  DmlOperator --> IDmlOperator

  DmlOperatorTest --> DmlOperator
  IDmlOperator --> DmlOperator
  MockDmlOperator --> DmlOperator
  MockDmlOperatorTest --> DmlOperator
  SOrchestrator --> DmlOperator
  SOrchestratorTest --> DmlOperator

  MockDmlOperator --> IDmlOperator
  MockDmlOperatorTest --> DmlOperatorTest
  MockDmlOperatorTest --> MockDmlOperator
  SOrchestrator --> IDmlOperator
  SOrchestratorTest --> MockDmlOperator
  SOrchestratorTest --> SOrchestrator

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0 stroke:#4C9F70,stroke-width:4px;
linkStyle 1,2,3,4,5,6 stroke:#FF8C00,stroke-width:2px;
linkStyle 7,8,9,10,11,12 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
public with sharing class DmlOperator implements IDmlOperator {
  public void doInsert(List<SObject> records){
    System.debug('Inserting ' + records.size() + ' records.');
    insert records;
  }
  public void doUpdate(List<SObject> records){
    update records;
  }
  public void doDelete(List<SObject> records) {
    delete records;
  }
}
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