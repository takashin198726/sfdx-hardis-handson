---
hide:
  - path
---

# ExcludeConditionClause Class

A concrete implementation of `AbstractConditionClause` that builds a 
SOQL `EXCLUDES` condition. 
 
This clause is specifically designed for filtering on multi-select picklist fields. 
It formats a list of string values into the required `('value1', 'value2')` syntax.

**See** [IConditionClause](IConditionClause.md)

**See** [AbstractConditionClause](AbstractConditionClause.md)

**Inheritance**

[AbstractConditionClause](AbstractConditionClause.md)

## Class Diagram

```mermaid
graph TD
  ExcludeConditionClause["ExcludeConditionClause"]:::mainApexClass
  click ExcludeConditionClause "/objects/ExcludeConditionClause/"
  AbstractConditionClause["AbstractConditionClause"]:::apexClass
  click AbstractConditionClause "/apex/AbstractConditionClause/"
  IConditionClause["IConditionClause"]:::apexClass
  click IConditionClause "/apex/IConditionClause/"
  ExcludeConditionClauseTest["ExcludeConditionClauseTest"]:::apexTestClass
  click ExcludeConditionClauseTest "/apex/ExcludeConditionClauseTest/"
  Scribe["Scribe"]:::apexClass
  click Scribe "/apex/Scribe/"

  ExcludeConditionClause --> AbstractConditionClause
  ExcludeConditionClause --> IConditionClause

  ExcludeConditionClauseTest --> ExcludeConditionClause
  Scribe --> ExcludeConditionClause

  AbstractConditionClause --> IConditionClause
  AbstractConditionClause --> Scribe
  IConditionClause --> AbstractConditionClause
  IConditionClause --> Scribe
  ExcludeConditionClauseTest --> IConditionClause
  Scribe --> IConditionClause

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1 stroke:#4C9F70,stroke-width:4px;
linkStyle 2,3 stroke:#FF8C00,stroke-width:2px;
linkStyle 4,5,6,7,8,9 stroke:#A6A6A6,stroke-width:2px;
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
 * @description A concrete implementation of `AbstractConditionClause` that builds a
 * SOQL `EXCLUDES` condition.
 *
 * This clause is specifically designed for filtering on multi-select picklist fields.
 * It formats a list of string values into the required `('value1', 'value2')` syntax.
 * @see IConditionClause
 * @see AbstractConditionClause
 */
public with sharing class ExcludeConditionClause extends AbstractConditionClause {
  private final List<String> values;

  /**
   * Constructor for ExcludeConditionClause.
   *
   * @param sObjectType The SObject type for the condition.
   * @param fieldMap A map of field names to Schema.SObjectField.
   * @param field The field name to apply the EXCLUDES condition on.
   * @param values A list of values to exclude.
   */
  public ExcludeConditionClause(
    Schema.SObjectType sObjectType,
    Map<String, Schema.SObjectField> fieldMap,
    String field,
    List<String> values
  ) {
    super(sObjectType, fieldMap, field);
    this.values = values;
  }

  /**
   * @inheritdoc
   */
  public override String build() {
    return String.format('{0} EXCLUDES ({1})', new List<String>{ this.field, this.checkAndCast() });
  }

  /**
   * @inheritdoc
   */
  public override IConditionClause overrideMetaData(
    Schema.SObjectType sObjectType,
    Map<String, Schema.SObjectField> fieldMap
  ) {
    return new ExcludeConditionClause(sObjectType, fieldMap, this.field, this.values);
  }

  /**
   * @inheritdoc
   */
  public override IConditionClause overrideField(String field) {
    return new ExcludeConditionClause(this.sObjectType, this.fieldMap, field, this.values);
  }

  /**
   * check the value type and cast it to string for SOQL
   *
   * @return The value formatted as a SOQL-compatible string.
   */
  private String checkAndCast() {
    List<String> castedValues = new List<String>();
    for (Object value : this.values) {
      castedValues.add('\'' + value + '\'');
    }

    return String.join(castedValues, ', ');
  }
}
```

## Fields
### `values`

#### Signature
```apex
private final values
```

#### Type
List<String>

## Constructors
### `ExcludeConditionClause(sObjectType, fieldMap, field, values)`

Constructor for ExcludeConditionClause.

#### Signature
```apex
public ExcludeConditionClause(Schema.SObjectType sObjectType, Map<String,Schema.SObjectField> fieldMap, String field, List<String> values)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjectType | Schema.SObjectType | The SObject type for the condition. |
| fieldMap | Map<String,Schema.SObjectField> | A map of field names to Schema.SObjectField. |
| field | String | The field name to apply the EXCLUDES condition on. |
| values | List<String> | A list of values to exclude. |

## Methods
### `build()`

**Inheritdoc**

#### Signature
```apex
public override String build()
```

#### Return Type
**String**

---

### `overrideMetaData(sObjectType, fieldMap)`

**Inheritdoc**

#### Signature
```apex
public override IConditionClause overrideMetaData(Schema.SObjectType sObjectType, Map<String,Schema.SObjectField> fieldMap)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| sObjectType | Schema.SObjectType |  |
| fieldMap | Map<String,Schema.SObjectField> |  |

#### Return Type
**[IConditionClause](IConditionClause.md)**

---

### `overrideField(field)`

**Inheritdoc**

#### Signature
```apex
public override IConditionClause overrideField(String field)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| field | String |  |

#### Return Type
**[IConditionClause](IConditionClause.md)**

---

### `checkAndCast()`

check the value type and cast it to string for SOQL

#### Signature
```apex
private String checkAndCast()
```

#### Return Type
**String**

The value formatted as a SOQL-compatible string.

---

### `getFieldName()`

*Inherited*

**InheritDoc**

#### Signature
```apex
public String getFieldName()
```

#### Return Type
**String**