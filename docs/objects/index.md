---
hide:
  - path
---

## Objects

| Name      | Label | Description |
| :-------- | :---- | :---------- | 
| [Account](Account.md) |  | <!-- --> |
| [Activity](Activity.md) |  | <!-- --> |
| [Asset](Asset.md) |  | <!-- --> |
| [Campaign](Campaign.md) |  | <!-- --> |
| [Case](Case.md) |  | <!-- --> |
| [Contact](Contact.md) |  | <!-- --> |
| [Contract](Contract.md) |  | <!-- --> |
| [Incident](Incident.md) |  | <!-- --> |
| [Lead](Lead.md) |  | <!-- --> |
| [Log__c](Log__c.md) | Log | Used by Nebula Logger to unify all log entries generated in a single transaction |
| [LogEntry__c](LogEntry__c.md) | Log Entry | Used by Nebula Logger to represent a single log message within a transaction - log entries can be generated via Apex, Flow, Process Builder, Lightning Web Components, and Aura Components. |
| [LogEntryDataMaskRule__mdt](LogEntryDataMaskRule__mdt.md) | Log Entry Data Mask Rule | Used to configure regex-based rules in Nebula Logger to mask sensitive data in log entry fields, such as LogEntryEvent__e.Message__c and LogEntry__c.Message__c |
| [LogEntryEvent__e](LogEntryEvent__e.md) | Log Entry Event | Platform Event object used by Nebula Logger for publishing debug and exception log entries |
| [LogEntryTag__c](LogEntryTag__c.md) | Log Entry Tag | Used by Nebula Logger as a junction object to represent a unique relationship between a LogEntry__c record and a LoggerTag__c record |
| [LogEntryTagRule__mdt](LogEntryTagRule__mdt.md) | Log Entry Tag Rule | Used to configure rules in Nebula Logger to assign additional tags to LogEntry__c records based on field values |
| [LoggerFieldMapping__mdt](LoggerFieldMapping__mdt.md) | Logger Field Mapping | Used to configure custom field mappings in Nebula Logger to map data between LogEntryEvent__e and the custom objects Log__c, LogEntry__c, and LoggerScenario__c |
| [LoggerParameter__mdt](LoggerParameter__mdt.md) | Logger Parameter | Used to configure key-value pair parameters in Nebula Logger to control systemwide features |
| [LoggerPlugin__mdt](LoggerPlugin__mdt.md) | Logger Plugin | Used to configure additional Apex classes and Flows that should be executed by Nebula Logger. Plugins can be built to be either a trigger-based plugin (automatically executed for all trigger operations on the included objects LogEntryEvent__e, LoggerScenario__c, Log__c, LogEntry__c, LogEntryTag__c, and LoggerTag__c), or either a batchable-based plugin (automatically executed the batch job LogBatchPurger), or both triggerable & batchable |
| [LoggerScenario__c](LoggerScenario__c.md) | Logger Scenario | Used by Nebula Logger to store unique scenarios (text/String) that can be used to identify Log__c and LogEntry__c records via the lookup fields Log__c.TransactionScenario__c and LogEntry__c.EntryScenario__c |
| [LoggerScenarioRule__mdt](LoggerScenarioRule__mdt.md) | Logger Scenario Rule | Used to configure rules in Nebula Logger to provide scenario-specific customizations |
| [LoggerSettings__c](LoggerSettings__c.md) | Logger Settings | Used to configure hierarchial settings in Nebula Logger to provide user-specific & profile-specific customizations |
| [LoggerSObjectHandler__mdt](LoggerSObjectHandler__mdt.md) | Logger SObject Handler | Used to configure Apex trigger handler classes in Nebula Logger that run on the included objects LogEntryEvent__e, LoggerScenario__c, Log__c, LogEntry__c, LogEntryTag__c, and LoggerTag__c |
| [LoggerTag__c](LoggerTag__c.md) | Logger Tag | Used by Nebula Logger for storing unique tags (text/String) that can be associated with LogEntry__c records via the junction object LogEntryTag__c |
| [LogStatus__mdt](LogStatus__mdt.md) | Log Status | Used to configure in Nebula Logger which picklist values in Log__c.Status__c are considered open/closed and resolved/unresolved |
| [MessagingEndUser](MessagingEndUser.md) |  | <!-- --> |
| [MusubuCompany__c](MusubuCompany__c.md) | 結ぶ法人情報 | 結ぶ法人情報。外部 API から取得した企業情報を管理します。 |
| [Opportunity](Opportunity.md) |  | <!-- --> |
| [Order](Order.md) |  | <!-- --> |
| [Product2](Product2.md) |  | <!-- --> |
| [Solution](Solution.md) |  | <!-- --> |
| [User](User.md) |  | <!-- --> |

_Documentation generated from branch main with [sfdx-hardis](https://sfdx-hardis.cloudity.com) by [Cloudity](https://cloudity.com) command [`sf hardis:doc:project2markdown`](https://sfdx-hardis.cloudity.com/hardis/doc/project2markdown/)_
