---
hide:
  - path
---

# LoggerEmailSender_Tests Class

`SUPPRESSWARNINGS`
`ISTEST`

## Class Diagram

```mermaid
graph TD
  LoggerEmailSender_Tests["LoggerEmailSender_Tests"]:::mainApexClass
  click LoggerEmailSender_Tests "/objects/LoggerEmailSender_Tests/"
  Entry["Entry"]:::apexClass
  click Entry "/apex/Entry/"
  Logger["Logger"]:::apexClass
  LoggerConfigurationSelector["LoggerConfigurationSelector"]:::apexTestClass
  LoggerEmailSender["LoggerEmailSender"]:::apexClass
  LoggerMockDataCreator["LoggerMockDataCreator"]:::apexTestClass
  LoggerParameter["LoggerParameter"]:::apexClass
  LoggerTestConfigurator["LoggerTestConfigurator"]:::apexTestClass

  LoggerEmailSender_Tests --> Entry
  LoggerEmailSender_Tests --> Logger
  LoggerEmailSender_Tests --> LoggerConfigurationSelector
  LoggerEmailSender_Tests --> LoggerEmailSender
  LoggerEmailSender_Tests --> LoggerMockDataCreator
  LoggerEmailSender_Tests --> LoggerParameter
  LoggerEmailSender_Tests --> LoggerTestConfigurator


  Logger --> Entry
  Logger --> LoggerEmailSender
  Logger --> LoggerParameter
  LoggerConfigurationSelector --> Entry
  LoggerConfigurationSelector --> Logger
  LoggerConfigurationSelector --> LoggerParameter
  LoggerEmailSender --> Logger
  LoggerEmailSender --> LoggerParameter
  LoggerMockDataCreator --> Logger
  LoggerMockDataCreator --> LoggerTestConfigurator
  LoggerParameter --> Entry
  LoggerParameter --> Logger
  LoggerParameter --> LoggerConfigurationSelector
  LoggerTestConfigurator --> Entry
  LoggerTestConfigurator --> Logger
  LoggerTestConfigurator --> LoggerMockDataCreator
  LoggerTestConfigurator --> LoggerParameter

classDef apexClass fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef apexTestClass fill:#F5F5F5,stroke:#999999,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainApexClass fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

linkStyle 0,1,2,3,4,5,6 stroke:#4C9F70,stroke-width:4px;
linkStyle 7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23 stroke:#A6A6A6,stroke-width:2px;
```

<!-- Apex description -->

## Apex Code

```java
//------------------------------------------------------------------------------------------------//
// This file is part of the Nebula Logger project, released under the MIT License.                //
// See LICENSE file or go to https://github.com/jongpie/NebulaLogger for full license details.    //
//------------------------------------------------------------------------------------------------//

@SuppressWarnings('PMD.MethodNamingConventions, PMD.PropertyNamingConventions')
@IsTest(IsParallel=true)
private class LoggerEmailSender_Tests {
  private static final Boolean IS_EMAIL_DELIVERABILITY_ENABLED {
    get {
      if (IS_EMAIL_DELIVERABILITY_ENABLED == null) {
        try {
          System.Messaging.reserveSingleEmailCapacity(1);
          IS_EMAIL_DELIVERABILITY_ENABLED = true;
        } catch (System.NoAccessException e) {
          IS_EMAIL_DELIVERABILITY_ENABLED = false;
        }
      }
      return IS_EMAIL_DELIVERABILITY_ENABLED;
    }
    set;
  }

  static {
    // Don't use the org's actual custom metadata records when running tests
    LoggerConfigurationSelector.useMocks();
  }

  @IsTest
  static void it_should_indicate_email_deliverability_is_based_on_email_deliverability_when_org_limits_not_exceeded() {
    System.OrgLimit singleEmailOrgLimit = OrgLimits.getMap().get('SingleEmail');
    System.Assert.isTrue(singleEmailOrgLimit.getValue() < singleEmailOrgLimit.getLimit());

    System.Assert.areEqual(IS_EMAIL_DELIVERABILITY_ENABLED, LoggerEmailSender.IS_EMAIL_DELIVERABILITY_AVAILABLE);
  }

  @IsTest
  static void it_should_indicate_email_deliverability_is_not_available_when_org_limits_exceeded() {
    // No need to fail the test if it's running in an org that does not have email deliverability enabled
    if (IS_EMAIL_DELIVERABILITY_ENABLED == false) {
      return;
    }

    System.OrgLimit singleEmailOrgLimit = OrgLimits.getMap().get('SingleEmail');

    // Reserve all of the available single email capacity, which is the effectively
    // the same as the email limit being exceeded in the org
    System.Messaging.reserveSingleEmailCapacity(singleEmailOrgLimit.getLimit() - singleEmailOrgLimit.getValue() - 1);

    System.Assert.isFalse(LoggerEmailSender.IS_EMAIL_DELIVERABILITY_AVAILABLE);
  }

  @IsTest
  static void it_should_send_email_notification_for_saveResult_errors_when_enabled() {
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(Email = 'some.email@test.com'));
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(UserId = System.UserInfo.getUserId()));
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent yet');

    Database.SaveResult saveResultWithError = LoggerMockDataCreator.createDatabaseSaveResult(false);
    LoggerEmailSender.sendErrorEmail(Schema.LogEntry__c.SObjectType, new List<Database.SaveResult>{ saveResultWithError });

    System.Assert.isTrue(
      LoggerEmailSender.SENT_EMAILS.get(0).getHtmlBody().contains(saveResultWithError.errors.get(0).getMessage()),
      'Email message should contain SaveResult error message'
    );
    List<String> errorFields = saveResultWithError.getErrors().get(0).getFields();
    String expectedFieldsError = 'Field(s): [' + String.join(errorFields, ', ') + ']';
    System.Assert.isTrue(
      LoggerEmailSender.SENT_EMAILS.get(0).getHtmlBody().contains(expectedFieldsError),
      'Email message should contain SaveResult error fields: ' + expectedFieldsError
    );
    if (LoggerEmailSender.IS_EMAIL_DELIVERABILITY_AVAILABLE) {
      System.Assert.areEqual(1, System.Limits.getEmailInvocations(), 'Email should have been sent');
    } else {
      System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'Deliverability is not currently enabled');
    }
  }

  @IsTest
  static void it_should_not_send_email_notification_for_saveResult_errors_when_no_recipients_configured() {
    LoggerTestConfigurator.setMock(new LoggerParameter__mdt(DeveloperName = 'SendErrorEmailNotifications', Value__c = 'true'));
    System.Assert.isTrue(LoggerParameter.SEND_ERROR_EMAIL_NOTIFICATIONS);
    LoggerEmailSender.CACHED_APEX_ERROR_RECIPIENTS.clear();
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent yet');

    Database.SaveResult saveResultWithError = LoggerMockDataCreator.createDatabaseSaveResult(false);
    LoggerEmailSender.sendErrorEmail(Schema.LogEntry__c.SObjectType, new List<Database.SaveResult>{ saveResultWithError });

    System.Assert.isTrue(LoggerEmailSender.SENT_EMAILS.isEmpty(), 'No email messages should have been generated');
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent');
  }

  @IsTest
  static void it_should_not_send_email_notification_for_saveResult_errors_when_disabled() {
    LoggerTestConfigurator.setMock(new LoggerParameter__mdt(DeveloperName = 'SendErrorEmailNotifications', Value__c = 'false'));
    System.Assert.isFalse(LoggerParameter.SEND_ERROR_EMAIL_NOTIFICATIONS);
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(Email = 'some.email@test.com'));
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(UserId = System.UserInfo.getUserId()));
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent yet');

    Database.SaveResult saveResultWithError = LoggerMockDataCreator.createDatabaseSaveResult(false);
    LoggerEmailSender.sendErrorEmail(Schema.LogEntry__c.SObjectType, new List<Database.SaveResult>{ saveResultWithError });

    System.Assert.isTrue(LoggerEmailSender.SENT_EMAILS.isEmpty(), 'No email messages should have been generated');
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent');
  }

  @IsTest
  static void it_should_send_email_notification_for_upsertResult_errors_when_enabled() {
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(Email = 'some.email@test.com'));
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(UserId = System.UserInfo.getUserId()));
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent yet');

    Database.UpsertResult upsertResultWithError = LoggerMockDataCreator.createDatabaseUpsertResult(false, false);
    LoggerEmailSender.sendErrorEmail(Schema.LogEntry__c.SObjectType, new List<Database.UpsertResult>{ upsertResultWithError });

    System.Assert.isTrue(
      LoggerEmailSender.SENT_EMAILS.get(0).getHtmlBody().contains(upsertResultWithError.errors.get(0).getMessage()),
      'Email message should contain UpsertResult error message'
    );
    List<String> errorFields = upsertResultWithError.getErrors().get(0).getFields();
    String expectedFieldsError = 'Field(s): [' + String.join(errorFields, ', ') + ']';
    System.Assert.isTrue(
      LoggerEmailSender.SENT_EMAILS.get(0).getHtmlBody().contains(expectedFieldsError),
      'Email message should contain UpsertResult error fields: ' + expectedFieldsError
    );
    if (LoggerEmailSender.IS_EMAIL_DELIVERABILITY_AVAILABLE) {
      System.Assert.areEqual(1, System.Limits.getEmailInvocations(), 'Email should have been sent');
    } else {
      System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'Deliverability is not currently enabled');
    }
  }

  @IsTest
  static void it_should_not_send_email_notification_for_upsertResult_errors_when_no_recipients_configured() {
    LoggerTestConfigurator.setMock(new LoggerParameter__mdt(DeveloperName = 'SendErrorEmailNotifications', Value__c = 'true'));
    System.Assert.isTrue(LoggerParameter.SEND_ERROR_EMAIL_NOTIFICATIONS);
    LoggerEmailSender.CACHED_APEX_ERROR_RECIPIENTS.clear();
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent yet');

    Database.UpsertResult upsertResultWithError = LoggerMockDataCreator.createDatabaseUpsertResult(false, false);
    LoggerEmailSender.sendErrorEmail(Schema.LogEntry__c.SObjectType, new List<Database.UpsertResult>{ upsertResultWithError });

    System.Assert.isTrue(LoggerEmailSender.SENT_EMAILS.isEmpty(), 'No email messages should have been generated');
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent');
  }

  @IsTest
  static void it_should_not_send_email_notification_for_upsertResult_errors_when_disabled() {
    LoggerTestConfigurator.setMock(new LoggerParameter__mdt(DeveloperName = 'SendErrorEmailNotifications', Value__c = 'false'));
    System.Assert.isFalse(LoggerParameter.SEND_ERROR_EMAIL_NOTIFICATIONS);
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(Email = 'some.email@test.com'));
    LoggerEmailSender.MOCK_NOTIFICATIONS.add(new Schema.ApexEmailNotification(UserId = System.UserInfo.getUserId()));
    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent yet');

    Database.UpsertResult upsertResultWithError = LoggerMockDataCreator.createDatabaseUpsertResult(false, false);
    LoggerEmailSender.sendErrorEmail(Schema.LogEntry__c.SObjectType, new List<Database.UpsertResult>{ upsertResultWithError });

    System.Assert.areEqual(0, System.Limits.getEmailInvocations(), 'No emails should have been sent');
    System.Assert.isTrue(LoggerEmailSender.SENT_EMAILS.isEmpty(), 'No email messages should have been generated');
  }
}
```

## Properties
### `IS_EMAIL_DELIVERABILITY_ENABLED`

#### Signature
```apex
private static final IS_EMAIL_DELIVERABILITY_ENABLED
```

#### Type
Boolean

## Methods
### `it_should_indicate_email_deliverability_is_based_on_email_deliverability_when_org_limits_not_exceeded()`

`ISTEST`

#### Signature
```apex
private static void it_should_indicate_email_deliverability_is_based_on_email_deliverability_when_org_limits_not_exceeded()
```

#### Return Type
**void**

---

### `it_should_indicate_email_deliverability_is_not_available_when_org_limits_exceeded()`

`ISTEST`

#### Signature
```apex
private static void it_should_indicate_email_deliverability_is_not_available_when_org_limits_exceeded()
```

#### Return Type
**void**

---

### `it_should_send_email_notification_for_saveResult_errors_when_enabled()`

`ISTEST`

#### Signature
```apex
private static void it_should_send_email_notification_for_saveResult_errors_when_enabled()
```

#### Return Type
**void**

---

### `it_should_not_send_email_notification_for_saveResult_errors_when_no_recipients_configured()`

`ISTEST`

#### Signature
```apex
private static void it_should_not_send_email_notification_for_saveResult_errors_when_no_recipients_configured()
```

#### Return Type
**void**

---

### `it_should_not_send_email_notification_for_saveResult_errors_when_disabled()`

`ISTEST`

#### Signature
```apex
private static void it_should_not_send_email_notification_for_saveResult_errors_when_disabled()
```

#### Return Type
**void**

---

### `it_should_send_email_notification_for_upsertResult_errors_when_enabled()`

`ISTEST`

#### Signature
```apex
private static void it_should_send_email_notification_for_upsertResult_errors_when_enabled()
```

#### Return Type
**void**

---

### `it_should_not_send_email_notification_for_upsertResult_errors_when_no_recipients_configured()`

`ISTEST`

#### Signature
```apex
private static void it_should_not_send_email_notification_for_upsertResult_errors_when_no_recipients_configured()
```

#### Return Type
**void**

---

### `it_should_not_send_email_notification_for_upsertResult_errors_when_disabled()`

`ISTEST`

#### Signature
```apex
private static void it_should_not_send_email_notification_for_upsertResult_errors_when_disabled()
```

#### Return Type
**void**