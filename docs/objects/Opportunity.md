---
hide:
  - path
---

<!-- This file is auto-generated. if you do not want it to be overwritten, set TRUE in the line below -->
<!-- DO_NOT_OVERWRITE_DOC=FALSE -->


## Schema

```mermaid
graph TD
Opportunity["Opportunity"]:::mainObject
click Opportunity "/objects/Opportunity/"


classDef object fill:#D6E9FF,stroke:#0070D2,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef customObject fill:#FFF4C2,stroke:#CCAA00,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef customObjectManaged fill:#FFD8B2,stroke:#CC5500,stroke-width:3px,rx:12px,ry:12px,shadow:drop,color:#333;
classDef mainObject fill:#FFB3B3,stroke:#A94442,stroke-width:4px,rx:14px,ry:14px,shadow:drop,color:#333,font-weight:bold;

```


<!-- Object description -->

## Fields

| Name      | Label | Type | Description |
| :-------- | :---- | :--: | :---------- | 
| AccountId |  | Lookup | undefined |
| Amount |  |  | undefined |
| CampaignId |  | Lookup | undefined |
| CloseDate |  |  | undefined |
| ContractId |  | Lookup | undefined |
| CurrentGenerators__c | Current Generator(s) | Text | undefined |
| DeliveryInstallationStatus__c | Delivery/Installation Status | Picklist | undefined |
| Description |  |  | undefined |
| ExpectedRevenue |  |  | undefined |
| IqScore |  |  | undefined |
| IsPrivate |  |  | undefined |
| LeadSource |  | Picklist | undefined |
| MainCompetitors__c | Main Competitor(s) | Text | undefined |
| Name |  |  | undefined |
| NextStep |  |  | undefined |
| OrderNumber__c | Order Number | Text | undefined |
| OwnerId |  | Lookup | undefined |
| Pricebook2Id |  | Lookup | undefined |
| Probability |  |  | undefined |
| Related_URL__c | 関連URL | Text | 関連するURLを格納するテキスト項目 |
| StageName |  | Picklist | undefined |
| SyncedQuoteId |  | Lookup | undefined |
| TotalOpportunityQuantity |  |  | undefined |
| TrackingNumber__c | Tracking Number | Text | undefined |
| Type |  | Picklist | undefined |


## Related Flows

| Object | Name      | Type | Description |
| :----  | :-------- | :--: | :---------- | 
| Opportunity | [High_Value_Opportunity_Task_Creation](../flows/High_Value_Opportunity_Task_Creation.md) [🕒](../flows/High_Value_Opportunity_Task_Creation-history.md) |  Record After Save | 商談の金額が100万円以上の場合に、自動的にフォローアップタスクを作成します。 |


## Related Apex Classes

| Apex Class | Type |
| :----      | :--: | 
| [EloquentTest](../apex/EloquentTest.md) | Test |
| [EntryTest](../apex/EntryTest.md) | Test |
| [EqualConditionClauseTest](../apex/EqualConditionClauseTest.md) | Test |
| [ExcludeConditionClauseTest](../apex/ExcludeConditionClauseTest.md) | Test |
| [GreaterThanConditionClauseTest](../apex/GreaterThanConditionClauseTest.md) | Test |
| [GreaterThanOrEqualConditionClauseTest](../apex/GreaterThanOrEqualConditionClauseTest.md) | Test |
| [InConditionClauseTest](../apex/InConditionClauseTest.md) | Test |
| [InSubQueryConditionClauseTest](../apex/InSubQueryConditionClauseTest.md) | Test |
| [IncludesConditionClauseTest](../apex/IncludesConditionClauseTest.md) | Test |
| [IsNotNullConditionClauseTest](../apex/IsNotNullConditionClauseTest.md) | Test |
| [IsNullConditionClauseTest](../apex/IsNullConditionClauseTest.md) | Test |
| [LessThanConditionClauseTest](../apex/LessThanConditionClauseTest.md) | Test |
| [LessThanOrEqualConditionClauseTest](../apex/LessThanOrEqualConditionClauseTest.md) | Test |
| [LikeConditionClauseTest](../apex/LikeConditionClauseTest.md) | Test |
| [MockEloquentTest](../apex/MockEloquentTest.md) | Test |
| [MockEntryTest](../apex/MockEntryTest.md) | Test |
| [NotEqualConditionClauseTest](../apex/NotEqualConditionClauseTest.md) | Test |
| [NotInConditionClauseTest](../apex/NotInConditionClauseTest.md) | Test |
| [NotInSubQueryConditionClauseTest](../apex/NotInSubQueryConditionClauseTest.md) | Test |
| [NotLikeConditionClauseTest](../apex/NotLikeConditionClauseTest.md) | Test |
| [SBluePrintTest](../apex/SBluePrintTest.md) | Test |
| [SOrchestratorTest](../apex/SOrchestratorTest.md) | Test |
| [Scribe](../apex/Scribe.md) | Class |
| [ScribeTest](../apex/ScribeTest.md) | Test |
| [SmartBlueprint](../apex/SmartBlueprint.md) | Class |
| [SmartBlueprintTest](../apex/SmartBlueprintTest.md) | Test |




## Related Profiles

| Profile | User License |
| :----      | :--: | 
| [Admin](../profiles/Admin.md) |  Salesforce |
| [Analytics Cloud Integration User](../profiles/Analytics%20Cloud%20Integration%20User.md) |  Analytics  Cloud  Integration  User |
| [Analytics Cloud Security User](../profiles/Analytics%20Cloud%20Security%20User.md) |  Analytics  Cloud  Integration  User |
| [Anypoint Integration](../profiles/Anypoint%20Integration.md) |  Identity |
| [Authenticated Website](../profiles/Authenticated%20Website.md) |  Authenticated  Website |
| [B2B Reordering Portal Buyer Profile](../profiles/B2B%20Reordering%20Portal%20Buyer%20Profile.md) |  External  Apps  Login |
| [Chatter External User](../profiles/Chatter%20External%20User.md) |  Chatter  External |
| [Chatter Free User](../profiles/Chatter%20Free%20User.md) |  Chatter  Free |
| [Chatter Moderator User](../profiles/Chatter%20Moderator%20User.md) |  Chatter  Free |
| [ContractManager](../profiles/ContractManager.md) |  Salesforce |
| [Cross Org Data Proxy User](../profiles/Cross%20Org%20Data%20Proxy%20User.md) |  X Org  Proxy  User |
| [Custom%3A Marketing Profile](../profiles/Custom%253A%20Marketing%20Profile.md) |  Salesforce |
| [Custom%3A Sales Profile](../profiles/Custom%253A%20Sales%20Profile.md) |  Salesforce |
| [Custom%3A Support Profile](../profiles/Custom%253A%20Support%20Profile.md) |  Salesforce |
| [Customer Community Login User](../profiles/Customer%20Community%20Login%20User.md) |  Customer  Community  Login |
| [Customer Community Plus Login User](../profiles/Customer%20Community%20Plus%20Login%20User.md) |  Customer  Community  Plus  Login |
| [Customer Community Plus User](../profiles/Customer%20Community%20Plus%20User.md) |  Customer  Community  Plus |
| [Customer Community User](../profiles/Customer%20Community%20User.md) |  Customer  Community |
| [Customer Portal Manager Custom](../profiles/Customer%20Portal%20Manager%20Custom.md) |  Customer  Portal  Manager  Custom |
| [Customer Portal Manager Standard](../profiles/Customer%20Portal%20Manager%20Standard.md) |  Customer  Portal  Manager  Standard |
| [Einstein Agent User](../profiles/Einstein%20Agent%20User.md) |  Einstein  Agent |
| [External Apps Login User](../profiles/External%20Apps%20Login%20User.md) |  External  Apps  Login |
| [External Identity User](../profiles/External%20Identity%20User.md) |  External  Identity |
| [Force%2Ecom - App Subscription User](../profiles/Force%252Ecom%20-%20App%20Subscription%20User.md) |  Force.com -  App  Subscription |
| [Force%2Ecom - Free User](../profiles/Force%252Ecom%20-%20Free%20User.md) |  Force.com -  Free |
| [Gold Partner User](../profiles/Gold%20Partner%20User.md) |  Gold  Partner |
| [High Volume Customer Portal User](../profiles/High%20Volume%20Customer%20Portal%20User.md) |  High  Volume  Customer  Portal |
| [HighVolumePortal](../profiles/HighVolumePortal.md) |  High  Volume  Customer  Portal |
| [Identity User](../profiles/Identity%20User.md) |  Identity |
| [MarketingProfile](../profiles/MarketingProfile.md) |  Salesforce |
| [Minimum Access - API Only Integrations](../profiles/Minimum%20Access%20-%20API%20Only%20Integrations.md) |  Salesforce  Integration |
| [Minimum Access - Salesforce](../profiles/Minimum%20Access%20-%20Salesforce.md) |  Salesforce |
| [Partner App Subscription User](../profiles/Partner%20App%20Subscription%20User.md) |  Partner  App  Subscription |
| [Partner Community Login User](../profiles/Partner%20Community%20Login%20User.md) |  Partner  Community  Login |
| [Partner Community User](../profiles/Partner%20Community%20User.md) |  Partner  Community |
| [PlatformPortal](../profiles/PlatformPortal.md) |  Authenticated  Website |
| [Read Only](../profiles/Read%20Only.md) |  Salesforce |
| [Salesforce API Only System Integrations](../profiles/Salesforce%20API%20Only%20System%20Integrations.md) |  Salesforce  Integration |
| [Silver Partner User](../profiles/Silver%20Partner%20User.md) |  Silver  Partner |
| [SolutionManager](../profiles/SolutionManager.md) |  Salesforce |
| [Standard](../profiles/Standard.md) |  Salesforce |
| [StandardAul](../profiles/StandardAul.md) |  Salesforce  Platform |
| [Work%2Ecom Only User](../profiles/Work%252Ecom%20Only%20User.md) |  Work.com  Only |




_Documentation generated with [sfdx-hardis](https://sfdx-hardis.cloudity.com), by [Cloudity](https://www.cloudity.com/) & [friends](https://github.com/hardisgroupcom/sfdx-hardis/graphs/contributors)_
