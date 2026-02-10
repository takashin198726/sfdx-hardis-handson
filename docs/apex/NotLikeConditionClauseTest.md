---
hide:
  - path
---

# NotLikeConditionClauseTest Class

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
  NotLikeConditionClauseTest["NotLikeConditionClauseTest"]:::mainApexClass
  click NotLikeConditionClauseTest "/objects/NotLikeConditionClauseTest/"
  IConditionClause["IConditionClause"]:::apexClass
  click IConditionClause "/apex/IConditionClause/"
  LikeConditionClause["LikeConditionClause"]:::apexClass
  click LikeConditionClause "/apex/LikeConditionClause/"
  LikeConditionClauseTest["LikeConditionClauseTest"]:::apexTestClass
  click LikeConditionClauseTest "/apex/LikeConditionClauseTest/"
  NotLikeConditionClause["NotLikeConditionClause"]:::apexClass
  click NotLikeConditionClause "/apex/NotLikeConditionClause/"

  NotLikeConditionClauseTest --> IConditionClause
  NotLikeConditionClauseTest --> LikeConditionClause
  NotLikeConditionClauseTest --> LikeConditionClauseTest
  NotLikeConditionClauseTest --> NotLikeConditionClause


  LikeConditionClause --> IConditionClause
  LikeConditionClauseTest --> IConditionClause
  LikeConditionClauseTest --> LikeConditionClause
  NotLikeConditionClause --> IConditionClause
  NotLikeConditionClause --> LikeConditionClause

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1,2,3 stroke:#4C9F70,stroke-width:4px;
linkStyle 4,5,6,7,8 stroke:#A6A6A6,stroke-width:2px;
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
public class NotLikeConditionClauseTest {
  @isTest
  static void testBuild_WhenValueIsValidString_ThenReturnsNotLikeClause() {
    // Arrange
    Schema.SObjectType sObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
    IConditionClause clause = new NotLikeConditionClause(sObjectType, fieldMap, 'Name', '%Test Corp%');

    // Act
    String result = clause.build();

    // Assert
    Assert.areEqual(
      '(NOT Name LIKE \'%Test Corp%\')',
      result,
      'The NOT LIKE condition string should be correctly formatted.'
    );
  }

  @isTest
  static void testBuild_WhenValueIsNull_ThenThrowException() {
    // Arrange
    Schema.SObjectType sObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
    IConditionClause clause = new NotLikeConditionClause(sObjectType, fieldMap, 'Name', null);

    // Act & Assert
    try {
      clause.build();
      Assert.fail('Expected a QueryException to be thrown for null value.');
    } catch (QueryException e) {
      String expectedMessage = 'Value cannot be null for NOT LIKE condition. field: Name';
      Assert.areEqual(expectedMessage, e.getMessage(), 'The exception message should match.');
    }
  }

  @isTest
  static void testImmutability_WhenOverrideMetaData_ThenReturnsNewInstance() {
    // Arrange
    Schema.SObjectType accountSObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> accountFieldMap = accountSObjectType.getDescribe().fields.getMap();
    IConditionClause originalClause = new NotLikeConditionClause(
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
    Assert.areEqual(
      '(NOT Name LIKE \'Test%\')',
      originalClause.build(),
      'Original instance should not be modified.'
    );
  }

  @isTest
  static void testImmutability_WhenOverrideField_ThenReturnsNewInstanceWithNewField() {
    // Arrange
    Schema.SObjectType sObjectType = Account.getSObjectType();
    Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
    IConditionClause originalClause = new NotLikeConditionClause(sObjectType, fieldMap, 'Name', 'Test%');

    // Act
    IConditionClause newClause = originalClause.overrideField('BillingStreet');

    // Assert
    Assert.areNotEqual(originalClause, newClause, 'A new instance should be returned.');
    Assert.areEqual(
      '(NOT Name LIKE \'Test%\')',
      originalClause.build(),
      'Original instance should not be modified.'
    );
    Assert.areEqual(
      '(NOT BillingStreet LIKE \'Test%\')',
      newClause.build(),
      'New instance should reflect the overridden field name.'
    );
  }
}
```

## Methods
### `testBuild_WhenValueIsValidString_ThenReturnsNotLikeClause()`

`ISTEST`

#### Signature
```apex
private static void testBuild_WhenValueIsValidString_ThenReturnsNotLikeClause()
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