---
hide:
  - path
---

# IAggregateClause Interface

An interface for classes that build a single aggregate function clause in a SOQL query. 
 
Implementations of this interface are responsible for generating a specific aggregate 
expression, such as &quot;SUM(Amount) totalAmount&quot;. This allows the Scribe builder to 
handle various aggregate functions in a polymorphic and extensible way.

**See** [AbstractAggregateClause](AbstractAggregateClause.md)

**See** [Scribe](Scribe.md)

## Class Diagram

```mermaid
graph LR
  IAggregateClause["IAggregateClause"]:::mainApexClass
  click IAggregateClause "/objects/IAggregateClause/"
  AbstractAggregateClause["AbstractAggregateClause"]:::apexClass
  click AbstractAggregateClause "/apex/AbstractAggregateClause/"
  Scribe["Scribe"]:::apexClass
  click Scribe "/apex/Scribe/"
  AverageClause["AverageClause"]:::apexClass
  click AverageClause "/apex/AverageClause/"
  CountClause["CountClause"]:::apexClass
  click CountClause "/apex/CountClause/"
  CountDistinctClause["CountDistinctClause"]:::apexClass
  click CountDistinctClause "/apex/CountDistinctClause/"
  MaxClause["MaxClause"]:::apexClass
  click MaxClause "/apex/MaxClause/"
  MinClause["MinClause"]:::apexClass
  click MinClause "/apex/MinClause/"
  SumClause["SumClause"]:::apexClass
  click SumClause "/apex/SumClause/"

  IAggregateClause --> AbstractAggregateClause
  IAggregateClause --> Scribe

  AbstractAggregateClause --> IAggregateClause
  AverageClause --> IAggregateClause
  CountClause --> IAggregateClause
  CountDistinctClause --> IAggregateClause
  MaxClause --> IAggregateClause
  MinClause --> IAggregateClause
  Scribe --> IAggregateClause
  SumClause --> IAggregateClause

  AbstractAggregateClause --> Scribe
  Scribe --> AverageClause
  Scribe --> CountClause
  Scribe --> CountDistinctClause
  Scribe --> MaxClause
  Scribe --> MinClause
  Scribe --> SumClause
  AverageClause --> AbstractAggregateClause
  CountClause --> AbstractAggregateClause
  CountDistinctClause --> AbstractAggregateClause
  MaxClause --> AbstractAggregateClause
  MinClause --> AbstractAggregateClause
  SumClause --> AbstractAggregateClause

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1 stroke:#4C9F70,stroke-width:4px;
linkStyle 2,3,4,5,6,7,8,9 stroke:#FF8C00,stroke-width:2px;
linkStyle 10,11,12,13,14,15,16,17,18,19,20,21,22 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
/**
 * Copyright 2025 Hiroyuki Matsuoka
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * @description An interface for classes that build a single aggregate function clause in a SOQL query.
 *
 * Implementations of this interface are responsible for generating a specific aggregate
 * expression, such as "SUM(Amount) totalAmount". This allows the Scribe builder to
 * handle various aggregate functions in a polymorphic and extensible way.
 * @see AbstractAggregateClause
 * @see Scribe
 */
public interface IAggregateClause {
  /**
   * Builds the aggregate clause string.
   *
   * @return The constructed aggregate clause.
   */
  String build();

  /**
   * Builds the aggregate clause with a relationship name prefix for parent relationship queries.
   *
   * @param parentRelationName The relationship name of the parent object.
   * @return The constructed aggregate clause with the relationship prefix.
   */
  String buildWithChild(String parentRelationName);

  /**
   * Gets the alias defined for this aggregate clause.
   *
   * @return The alias.
   */
  String getAlias();

  /**
   * Gets the API name of the field being aggregated.
   *
   * @return The field's API name.
   */
  String getFieldName();

  /**
   * Overrides the internal metadata for the clause.
   *
   * @param sObjectType The SObjectType to use for context.
   * @param fieldMap The field map of the relevant SObject.
   * @return A new IAggregateClause instance with the updated metadata.
   */
  IAggregateClause overrideMetaData(Schema.SObjectType sObjectType, Map<String, Schema.SObjectField> fieldMap);
}
```

## Methods
### `build()`

Builds the aggregate clause string.

#### Signature
```apex
public String build()
```

#### Return Type
**String**

The constructed aggregate clause.

---

### `buildWithChild(parentRelationName)`

Builds the aggregate clause with a relationship name prefix for parent relationship queries.

#### Signature
```apex
public String buildWithChild(String parentRelationName)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| parentRelationName | String | The relationship name of the parent object. |

#### Return Type
**String**

The constructed aggregate clause with the relationship prefix.

---

### `getAlias()`

Gets the alias defined for this aggregate clause.

#### Signature
```apex
public String getAlias()
```

#### Return Type
**String**

The alias.

---

### `getFieldName()`

Gets the API name of the field being aggregated.

#### Signature
```apex
public String getFieldName()
```

#### Return Type
**String**

The field&#x27;s API name.

---

### `overrideMetaData(sObjectType, fieldMap)`

Overrides the internal metadata for the clause.

#### Signature
```apex
public IAggregateClause overrideMetaData(Schema.SObjectType sObjectType, Map<String,Schema.SObjectField> fieldMap)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjectType | Schema.SObjectType | The SObjectType to use for context. |
| fieldMap | Map<String,Schema.SObjectField> | The field map of the relevant SObject. |

#### Return Type
**[IAggregateClause](IAggregateClause.md)**

A new IAggregateClause instance with the updated metadata.