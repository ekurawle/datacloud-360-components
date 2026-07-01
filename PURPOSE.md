# Purpose & Use Case Documentation

## 🎯 Component Purpose

The **Data Cloud 360 Components** package is designed to solve one specific problem:

> **"How do I display Data Cloud (DMO) lookup fields as clickable links on my Salesforce record pages?"**

When your CRM records (Opportunities, Accounts, Cases, etc.) have lookup relationships to **Data Model Objects (DMOs)** in Data Cloud, Salesforce typically displays these as plain text fields. This component transforms those text values into **interactive, clickable links** that navigate directly to the Data Cloud record page.

---

## 💡 The Problem

### Before This Component:

**Scenario**: You have an Opportunity record with these fields:
- `Drug_Brand_Name__c` = "Sodium Iodide"
- `GlobalData_Drug__r.DrugID_Text__c` = "12345"
- The drug data actually lives in Data Cloud as `Drug_Data_Unified__dlm`

**What users see**: Just the text "Sodium Iodide"

**What users want**: A clickable link to open the full Data Cloud record page

**Manual workaround**: 
1. Copy the Drug ID
2. Go to Data Cloud app
3. Search for the record
4. Click through to find it

**Result**: Lost productivity, context switching, poor user experience

---

## ✅ The Solution

### After Installing This Component:

**What users see**: 
```
┌────────────────────────────────────────────┐
│  Data 360 - Cross Sell Attributes          │
│                                            │
│  Drug                                      │
│  🔗 Sodium Iodide  ← Clickable link       │
│                                            │
└────────────────────────────────────────────┘
```

**What happens on click**: 
- Instant navigation to `/lightning/r/Drug_Data_Unified__dlm/[RecordId]/view`
- Or CDP page: `/lightning/cdp/UnifiedssotAccountAcct__dlm/[RecordId]/view`
- No searching, no context switching

**Result**: 
- ⚡ Faster navigation (click vs. search)
- 🎯 Better UX (direct access to related data)
- 📊 Cross-org visibility (see data from other business units)
- 💼 Increased productivity (less time hunting for records)

---

## 🏢 Real-World Business Context

### Use Case: Cross-Business Unit Sales Visibility

**Company**: Pharmaceutical company with multiple business units (e.g., Clinical Research Group + Product Supply Group)

**Challenge**: 
- CRG and PSG use separate Salesforce orgs
- Sales reps in CRG can't see PSG opportunities
- Data is unified in Data Cloud, but no easy way to surface it in CRM
- Reps miss cross-sell opportunities
- Time wasted searching for account context

**Solution Architecture**:

1. **Data Cloud** consolidates:
   - Drug records from both orgs → `Drug_Data_Unified__dlm`
   - Bundle/Product records → `Bundle_Data_Unified__dlm`
   - Account records → `UnifiedssotAccountAcct__dlm`

2. **CRM records** have lookup fields to these DMOs:
   - `Opportunity.GlobalData_Drug__r` → Points to unified drug
   - `Opportunity.Bundle__c` → Points to unified bundle
   - `Opportunity.Parent_Account__c` → Points to unified account

3. **This Component** surfaces those lookups as clickable links:
   - Embedded on Opportunity record pages
   - Displays as a highlight panel (matches Salesforce UI)
   - Shows 3 columns: Drug | Bundle | Parent Account
   - Each is a direct link to the DMO record page

**Business Impact**:
- ✅ CRG reps see PSG data without leaving their org
- ✅ Cross-sell opportunities identified automatically
- ✅ 360° account view for better customer engagement
- ✅ Reduced time-to-insight (seconds vs. minutes)

---

## 🎨 Component Display: Highlight Panel

This component renders as a **Salesforce Highlight Panel**, which is the same design pattern used for standard related lists and key information sections.

### Visual Layout:

```
┌──────────────────────────────────────────────────────────────────┐
│  🗺️  Data 360 - Cross Sell Attributes                            │
│  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  │
│                                                                   │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │      Drug       │  │     Bundle      │  │  Parent Account │ │
│  ├─────────────────┤  ├─────────────────┤  ├─────────────────┤ │
│  │ Sodium Iodide   │  │ 01188          │  │ Faraday Pharma  │ │
│  │ 🔗 Click to view│  │ 🔗 Click to view│  │ 🔗 Click to view│ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
│                                                                   │
│  [Each is a hyperlink to the DMO record page]                    │
└──────────────────────────────────────────────────────────────────┘
```

### Placement on Record Page:

Typically placed **above the Details tab**, in the record page header section:

```
┌──────────────────────────────────────────────────────────────┐
│  Opportunity: Q1 2026 - Faraday Deal         [Edit] [Delete] │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────────────────────────────────────────────┐│
│  │  🗺️  Data 360 - Cross Sell Attributes   ← THIS COMPONENT││
│  │  Drug | Bundle | Parent Account                          ││
│  └──────────────────────────────────────────────────────────┘│
│                                                               │
│  [Details] [Related] [Activity] [...other tabs]              │
│                                                               │
│  Stage: Proposal/Quote                                       │
│  Amount: $250,000                                             │
│  Close Date: 2026-03-31                                      │
│  ...                                                          │
└──────────────────────────────────────────────────────────────┘
```

---

## 🔄 How Data Flows

### Step-by-Step Process:

1. **User opens Opportunity record**
   - Lightning page loads
   - Component initializes

2. **Component reads CRM fields**
   - `GlobalData_Drug__r.DrugID_Text__c` = "12345"
   - `Drug_Brand_Name__c` = "Sodium Iodide"
   - `Bundle__c` = "01188"
   - `Parent_Account_ID__c` = "ACC-789"

3. **Component queries Data Cloud** (via Apex controller)
   ```sql
   -- Query 1: Get Drug DMO record
   SELECT Id, Drug_Name__c 
   FROM Drug_Data_Unified__dlm 
   WHERE CRG_Drug_Id_Text__c = '12345'
   WITH SECURITY_ENFORCED
   LIMIT 1
   
   -- Query 2: Get Bundle DMO record
   SELECT Id, Bundle_Name__c 
   FROM Bundle_Data_Unified__dlm 
   WHERE Bundle_ID__c = '01188'
   WITH SECURITY_ENFORCED
   LIMIT 1
   
   -- Query 3: Get Account DMO record
   SELECT Id, Account_Name__c 
   FROM UnifiedssotAccountAcct__dlm 
   WHERE Account_ID__c = 'ACC-789'
   WITH SECURITY_ENFORCED
   LIMIT 1
   ```

4. **Component builds navigation URLs**
   ```
   Drug Link:    /lightning/r/Drug_Data_Unified__dlm/[DMO_RecordId]/view
   Bundle Link:  /lightning/r/Bundle_Data_Unified__dlm/[DMO_RecordId]/view
   Account Link: /lightning/cdp/UnifiedssotAccountAcct__dlm/[DMO_RecordId]/view
   ```

5. **Component renders clickable links**
   - Displays as styled hyperlinks
   - Uses CRM field values as display text
   - Links point to DMO record pages

6. **User clicks link**
   - Navigates to Data Cloud record page in same tab
   - Full DMO record details displayed
   - User can navigate back to Opportunity

---

## 🏗️ Technical Architecture

### Component Stack:

```
┌──────────────────────────────────────────────────────────────┐
│                  Lightning Record Page                        │
│  ┌────────────────────────────────────────────────────────┐ │
│  │  dataCloudMultiColumnCard (Parent LWC)                 │ │
│  │                                                         │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐│ │
│  │  │dataCloudRel. │  │dataCloudRel. │  │dataCloudRel. ││ │
│  │  │Field (Col 1) │  │Field (Col 2) │  │Field (Col 3) ││ │
│  │  │              │  │              │  │              ││ │
│  │  │ - Reads CRM  │  │ - Reads CRM  │  │ - Reads CRM  ││ │
│  │  │ - Calls Apex │  │ - Calls Apex │  │ - Calls Apex ││ │
│  │  │ - Renders    │  │ - Renders    │  │ - Renders    ││ │
│  │  │   link       │  │   link       │  │   link       ││ │
│  │  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘│ │
│  └─────────┼──────────────────┼──────────────────┼────────┘ │
│            │                  │                  │          │
└────────────┼──────────────────┼──────────────────┼──────────┘
             │                  │                  │
             ▼                  ▼                  ▼
     ┌────────────────────────────────────────────────────────┐
     │  DataCloudRelatedFieldController (Apex)                │
     │  - getDrugRecords(searchValue, dmoName, ...)          │
     │  - Dynamic SOQL generation                             │
     │  - WITH SECURITY_ENFORCED                              │
     │  - Returns DMO records with Id for navigation          │
     └──────────────────────┬─────────────────────────────────┘
                            │
                            ▼
                ┌───────────────────────────┐
                │  Data Cloud (CDP)         │
                │  - Drug_Data_Unified__dlm │
                │  - Bundle_Data_Unified__dlm│
                │  - UnifiedAccount__dlm    │
                └───────────────────────────┘
```

### Key Design Decisions:

1. **Parent-Child Component Pattern**
   - `dataCloudMultiColumnCard` = Container
   - `dataCloudRelatedField` = Reusable column
   - Enables 1-3 columns with same logic

2. **Imperative Apex Calls**
   - Not using `@wire` decorator
   - Avoids race conditions on heavy pages
   - Better error handling

3. **Dynamic SOQL**
   - Queries are built at runtime
   - Works with any DMO object
   - Requires `WITH SECURITY_ENFORCED`

4. **Caching Enabled**
   - `@AuraEnabled(cacheable=true)`
   - Improves performance
   - Requires read-only operations

5. **Conditional Rendering**
   - Columns auto-hide if data is invalid
   - Prevents broken links
   - Cleaner UI

---

## 📋 Configuration Requirements

To use this component, you need:

### 1. **Data Cloud Objects (DMOs)**
   - DMOs must exist in your org
   - Example: `Drug_Data_Unified__dlm`
   - Must have a search field (e.g., `CRG_Drug_Id_Text__c`)
   - Must have a display field (e.g., `Drug_Name__c`)

### 2. **CRM Record Fields**
   - Your CRM object (Opportunity, Account, etc.) must have:
     - **Search field**: Contains the value to query DMO (e.g., `GlobalData_Drug__r.DrugID_Text__c`)
     - **Display field**: Contains the value to show to users (e.g., `Drug_Brand_Name__c`)

### 3. **Field-Level Security**
   - User must have **Read** access to:
     - All CRM fields used in configuration
     - All DMO fields used in queries
   - User must have **Read** access to DMO objects

### 4. **Data Cloud Enabled**
   - Your Salesforce org must have Data Cloud provisioned
   - DMO objects must be accessible via SOQL

---

## 🎓 When to Use This Component

### ✅ **Use When:**

- You have CRM records with lookups to Data Cloud objects (DMOs)
- You want users to quickly navigate to DMO record pages
- You need a highlight panel design (Salesforce standard UI)
- You want no-code configuration in App Builder
- You need up to 3 related DMO records displayed together
- You want automatic show/hide based on data validity

### ❌ **Don't Use When:**

- You need to display more than 3 DMO records (component limit)
- You need inline editing (component is read-only)
- You need to display a list/table of records (component shows 1 record per column)
- You don't have Data Cloud enabled
- Your data isn't in Data Cloud DMOs (use standard related lists instead)

---

## 📊 Success Metrics

After implementing this component, you can measure:

1. **Time Saved**
   - Before: ~30-60 seconds to manually search for DMO record
   - After: ~2 seconds to click link
   - **Savings**: 28-58 seconds per lookup

2. **User Adoption**
   - Track navigation events (link clicks)
   - Monitor Data Cloud record page views
   - Survey user satisfaction

3. **Cross-Sell Opportunities**
   - If using for cross-business visibility:
   - Track how many cross-sell opportunities identified
   - Measure revenue impact

4. **Data Quality**
   - Monitor "No Data" message frequency
   - Identify records with missing/invalid DMO lookups
   - Use to improve data hygiene

---

## 🔗 Related Resources

- **Salesforce Data Cloud**: https://www.salesforce.com/products/data-cloud/overview/
- **DMO Documentation**: https://help.salesforce.com/s/articleView?id=sf.c360_a_data_model_objects.htm
- **Lightning App Builder**: https://help.salesforce.com/s/articleView?id=sf.lightning_app_builder_overview.htm
- **Lightning Web Components**: https://developer.salesforce.com/docs/component-library/documentation/en/lwc

---

## 💬 Common Questions

### Q: Can I use this for regular Salesforce objects (not DMOs)?
**A**: Technically yes, but it's designed for DMOs. For regular objects, use standard related lists or lookup fields.

### Q: Can I add more than 3 columns?
**A**: Not currently. The component supports up to 3 columns. You'd need to modify the code to add more.

### Q: Does this work with Person Accounts?
**A**: Yes, as long as you're querying DMOs. The component is object-agnostic.

### Q: Can I customize the styling?
**A**: Yes, you can modify the CSS in the component files after installation (it's an unmanaged package).

### Q: Does this work on mobile?
**A**: Yes, the component is fully responsive and works on Salesforce Mobile.

### Q: What happens if the DMO record doesn't exist?
**A**: The component shows a "No records found" message. You can configure a custom message.

### Q: Can I use this in Experience Cloud (Communities)?
**A**: Potentially, but it would need to be exposed in the metadata. Currently configured for internal pages only.

---

**For installation and configuration instructions, see [README.md](./README.md)**
