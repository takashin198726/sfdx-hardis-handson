---
hide:
  - path
---

# IDmlOperator Interface

## Class Diagram

```mermaid
graph TD
  IDmlOperator["IDmlOperator"]:::mainApexClass
  click IDmlOperator "/objects/IDmlOperator/"
  DmlOperator["DmlOperator"]:::apexClass
  click DmlOperator "/apex/DmlOperator/"
  MockDmlOperator["MockDmlOperator"]:::apexClass
  click MockDmlOperator "/apex/MockDmlOperator/"
  SOrchestrator["SOrchestrator"]:::apexClass
  click SOrchestrator "/apex/SOrchestrator/"

  IDmlOperator --> DmlOperator

  DmlOperator --> IDmlOperator
  MockDmlOperator --> IDmlOperator
  SOrchestrator --> IDmlOperator

  MockDmlOperator --> DmlOperator
  SOrchestrator --> DmlOperator

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0 stroke:#4C9F70,stroke-width:4px;
linkStyle 1,2,3 stroke:#FF8C00,stroke-width:2px;
linkStyle 4,5 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
public interface IDmlOperator {
  void doInsert(List<SObject> records);
  void doUpdate(List<SObject> records);
  void doDelete(List<SObject> records);
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