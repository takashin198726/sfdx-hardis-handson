---
hide:
  - path
---

# LikeConditionClauseTest Class

`ISTEST`

Copyright 2025 Hiroyuki Matsuoka 
 
Licensed under the Apache License, Version 2.0 (the &quot;License&quot;); 
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 
 
http://www.apache.org/licenses/LICENSE-2.0 
 
Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an &quot;AS IS&quot; BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License.

## Class Diagram

```mermaid
graph TD
  LikeConditionClauseTest["LikeConditionClauseTest"]:::mainApexClass
  click LikeConditionClauseTest "/objects/LikeConditionClauseTest/"
  IConditionClause["IConditionClause"]:::apexClass
  click IConditionClause "/apex/IConditionClause/"
  LikeConditionClause["LikeConditionClause"]:::apexClass
  click LikeConditionClause "/apex/LikeConditionClause/"
  NotLikeConditionClauseTest["NotLikeConditionClauseTest"]:::apexTestClass
  click NotLikeConditionClauseTest "/apex/NotLikeConditionClauseTest/"

  LikeConditionClauseTest --> IConditionClause
  LikeConditionClauseTest --> LikeConditionClause

  NotLikeConditionClauseTest --> LikeConditionClauseTest

  LikeConditionClause --> IConditionClause
  NotLikeConditionClauseTest --> IConditionClause
  NotLikeConditionClauseTest --> LikeConditionClause

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1 stroke:#4C9F70,stroke-width:4px;
linkStyle 2 stroke:#FF8C00,stroke-width:2px;
linkStyle 3,4,5 stroke:#A6A6A6,stroke-width:2px;
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
@isTest
public class LikeConditionClauseTest {
  @isTest
  static void testBuild_WhenValueIsValidString_ThenReturnsLikeClause() {
    // Arrange
    Schema.SObjectType sObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
    IConditionClause clause = new LikeConditionClause(sObjectType, fieldMap, 'Name', '%Test Corp%');

    // Act
    String result = clause.build();

    // Assert
    Assert.areEqual(
      'Name LIKE \'%Test Corp%\'',
      result,
      'The LIKE condition string should be correctly formatted.'
    );
  }

  @isTest
  static void testBuild_WhenValueIsNull_ThenThrowException() {
    // Arrange
    Schema.SObjectType sObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
    IConditionClause clause = new LikeConditionClause(sObjectType, fieldMap, 'Name', null);

    // Act & Assert
    try {
      clause.build();
      Assert.fail('Expected a QueryException to be thrown for null value.');
    } catch (QueryException e) {
      String expectedMessage = 'Value cannot be null for LIKE condition. field: Name';
      Assert.areEqual(expectedMessage, e.getMessage(), 'The exception message should match.');
    }
  }

  @isTest
  static void testImmutability_WhenOverrideMetaData_ThenReturnsNewInstance() {
    // Arrange
    Schema.SObjectType accountSObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> accountFieldMap = accountSObjectType.getDescribe().fields.getMap();
    IConditionClause originalClause = new LikeConditionClause(
      accountSObjectType,
      accountFieldMap,
      'Name',
      'Test%'
    );

    // Act
    Schema.SObjectType oppSObjectType = Opportunity.getSObjectType();
    Map<String, Schema.SObjectField> oppFieldMap = oppSObjectType.getDescribe().fields.getMap();
    IConditionClause newClause = originalClause.overrideMetaData(oppSObjectType, oppFieldMap);

    // Assert
    Assert.areNotEqual(originalClause, newClause, 'A new instance should be returned.');
    Assert.areEqual('Name LIKE \'Test%\'', originalClause.build(), 'Original instance should not be modified.');
  }

  @isTest
  static void testImmutability_WhenOverrideField_ThenReturnsNewInstanceWithNewField() {
    // Arrange
    Schema.SObjectType sObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
    IConditionClause originalClause = new LikeConditionClause(sObjectType, fieldMap, 'Name', 'Test%');

    // Act
    IConditionClause newClause = originalClause.overrideField('BillingStreet');

    // Assert
    Assert.areNotEqual(originalClause, newClause, 'A new instance should be returned.');
    Assert.areEqual('Name LIKE \'Test%\'', originalClause.build(), 'Original instance should not be modified.');
    Assert.areEqual(
      'BillingStreet LIKE \'Test%\'',
      newClause.build(),
      'New instance should reflect the overridden field name.'
    );
  }
}
```

## Methods
### `testBuild_WhenValueIsValidString_ThenReturnsLikeClause()`

`ISTEST`

#### Signature
```apex
private static void testBuild_WhenValueIsValidString_ThenReturnsLikeClause()
```

#### Return Type
**void**

---

### `testBuild_WhenValueIsNull_ThenThrowException()`

`ISTEST`

#### Signature
```apex
private static void testBuild_WhenValueIsNull_ThenThrowException()
```

#### Return Type
**void**

---

### `testImmutability_WhenOverrideMetaData_ThenReturnsNewInstance()`

`ISTEST`

#### Signature
```apex
private static void testImmutability_WhenOverrideMetaData_ThenReturnsNewInstance()
```

#### Return Type
**void**

---

### `testImmutability_WhenOverrideField_ThenReturnsNewInstanceWithNewField()`

`ISTEST`

#### Signature
```apex
private static void testImmutability_WhenOverrideField_ThenReturnsNewInstanceWithNewField()
```

#### Return Type
**void**