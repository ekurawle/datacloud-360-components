# ☁️ Data Cloud 360 Components

> **Display Data Cloud (DMO) records as lookup fields on Salesforce record pages**  
> Surface unified data from Data Cloud directly on your CRM records with clickable links to DMO record pages.

[![Salesforce API](https://img.shields.io/badge/Salesforce%20API-v66.0-blue.svg)](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![LWC](https://img.shields.io/badge/LWC-Lightning%20Web%20Components-orange.svg)](https://developer.salesforce.com/docs/component-library/documentation/en/lwc)

---

## 🎯 What Problem Does This Solve?

When you have **CRM records with lookups to Data Cloud objects (DMOs)**, you typically only see the field value as text. This component transforms those text fields into **clickable links** that navigate directly to the Data Cloud record page, displayed as an elegant **highlight panel** on your record page.

### Real-World Example: Cross-Org Visibility

**Scenario**: Your Opportunity record has lookup fields to:
- **Unified Drug Record** (DMO) - `Drug_Data_Unified__dlm`
- **Unified Bundle** (DMO) - `Bundle_Data_Unified__dlm`  
- **Unified Account** (DMO) - `UnifiedssotAccountAcct__dlm`

**Without this component**: You see text values, no easy way to navigate to Data Cloud records.

**With this component**: You get a beautiful 3-column card showing clickable links to all related DMO records, enabling cross-business unit visibility and faster navigation.

---

## 📸 Preview

```
┌────────────────────────────────────────────────────────────────┐
│  🗺️  Data 360 - Cross Sell Attributes                         │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  Drug                Bundle              Parent Account        │
│  ──────────          ─────────           ─────────            │
│  🔗 Sodium Iodide    🔗 01188            🔗 Faraday Pharma    │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

**Displayed as a Highlight Panel on Opportunity/Account Records**

---

## ✨ Key Features

- ✅ **Displays DMO lookup fields as clickable links** to Data Cloud record pages
- ✅ **Highlight panel design** - Matches Salesforce Lightning UI patterns
- ✅ **Up to 3 configurable columns** - Show multiple related DMO records
- ✅ **Automatic navigation** - Direct links to `/lightning/cdp/` or `/lightning/r/` pages
- ✅ **Dynamic show/hide** - Columns auto-hide when data is missing or invalid
- ✅ **No-code configuration** - Fully configurable in Lightning App Builder
- ✅ **Mobile responsive** - Works on desktop and mobile
- ✅ **Loading states & error handling** - Professional UX throughout

---

## 🚀 Quick Install

### Option 1: Deploy with SFDX (Recommended)

```bash
# Clone this repository
git clone https://github.com/ekurawle/datacloud-360-components.git
cd datacloud-360-components

# Authenticate to your Salesforce org
sfdx auth:web:login -a MyOrg

# Deploy the package
sfdx force:source:deploy -p force-app -u MyOrg

# Run tests
sfdx force:apex:test:run -n DataCloudRelatedFieldControllerTest -u MyOrg
```

### Option 2: Deploy to Salesforce Button

[![Deploy to Salesforce](https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png)](https://githubsfdeploy.herokuapp.com)

*Click the button above to deploy directly to your org (requires connected app)*

### Option 3: Salesforce CLI with Manifest

```bash
# Clone the repo
git clone https://github.com/ekurawle/datacloud-360-components.git
cd datacloud-360-components

# Deploy using manifest
sfdx force:source:deploy -x manifest/package.xml -u MyOrg
```

### Option 4: Manual Installation

1. Download this repository as ZIP
2. Extract files
3. Use VS Code with Salesforce Extensions
4. Right-click `force-app` folder → "SFDX: Deploy Source to Org"

---

## 📦 What's Included

| Component | Type | Purpose |
|-----------|------|---------|
| **dataCloudMultiColumnCard** | LWC | Main container component - Drag onto record pages in App Builder. Creates the highlight panel and manages up to 3 columns. |
| **dataCloudRelatedField** | LWC | Individual column component - Renders each DMO lookup field as a clickable link. Handles loading, errors, and navigation. |
| **DataCloudRelatedFieldController** | Apex | Server-side controller - Dynamically queries Data Cloud objects (DMOs) using SOQL with security enforced. |
| **DataCloudRelatedFieldControllerTest** | Apex | Test class - Provides 90%+ code coverage with comprehensive test scenarios. |

**Total Package Size**: 25 files, ~3,000 lines (including documentation)

---

## 🎯 Real-World Use Cases

### 1. **Pharma: Cross-Business Unit Visibility**
**Problem**: Sales reps in Clinical Research Group (CRG) couldn't see Product Supply Group (PSG) data.  
**Solution**: Embed this component on Opportunity records to surface:
- **Drug** (from Data Cloud) - Shows unified drug data across business units
- **Bundle** - Product bundle information
- **Parent Account** - Consolidated account view

**Result**: Reps gain 360° visibility without leaving their org, enabling cross-sell opportunities.

---

### 2. **Healthcare: Patient Care Coordination**
Display on Patient records:
- **Unified Patient Profile** (DMO)
- **Primary Care Provider** (DMO)
- **Facility/Hospital** (DMO)

**Result**: Care coordinators see complete patient context with one click.

---

### 3. **Life Sciences: Clinical Trial Management**
Display on Clinical Study records:
- **Study Protocol** (DMO)
- **Investigational Product** (DMO)
- **Sponsor Organization** (DMO)

**Result**: Research coordinators access study data faster.

---

### 4. **Financial Services: Household Management**
Display on Account records:
- **Household Profile** (DMO)
- **Primary Contact** (DMO)
- **Investment Portfolio** (DMO)

**Result**: Advisors get unified household view.

---

### 5. **Retail: Product Catalog Integration**
Display on Order records:
- **Product** (DMO)
- **Category** (DMO)
- **Manufacturer/Supplier** (DMO)

**Result**: Order management team sees complete product lineage.

---

## 🔍 How It Works

This component bridges the gap between your **CRM records** and **Data Cloud (DMO) records**.

### The Flow:

1. **Your Opportunity/Account Record** has lookup fields to Data Cloud objects:
   ```
   Opportunity.GlobalData_Drug__r.DrugID_Text__c = "12345"
   Opportunity.Drug_Brand_Name__c = "Sodium Iodide"
   ```

2. **Component queries Data Cloud** using the lookup field value:
   ```sql
   SELECT Id, Drug_Name__c 
   FROM Drug_Data_Unified__dlm 
   WHERE CRG_Drug_Id_Text__c = '12345'
   ```

3. **Displays as clickable link**:
   ```
   Drug
   🔗 Sodium Iodide  ← Click navigates to /lightning/r/Drug_Data_Unified__dlm/[RecordId]/view
   ```

### Architecture:

```
┌─────────────────────────────────────────────────────────────┐
│                   Opportunity Record                         │
│                                                              │
│  ┌────────────────────────────────────────────────────────┐ │
│  │  Data 360 - Cross Sell Attributes                      │ │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────────────┐    │ │
│  │  │   Drug   │  │  Bundle  │  │  Parent Account  │    │ │
│  │  │ ───────  │  │ ──────── │  │ ──────────────── │    │ │
│  │  │🔗 Sodium │  │🔗 01188  │  │🔗 Faraday Pharma │    │ │
│  │  │  Iodide  │  │          │  │                  │    │ │
│  │  └──────────┘  └──────────┘  └──────────────────┘    │ │
│  │         ↓              ↓              ↓               │ │
│  │    DMO Link       DMO Link       DMO Link             │ │
│  └────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

Each column:
1. Reads the CRM field value
2. Queries the corresponding DMO
3. Displays a clickable link to the DMO record page

---

## 🔧 Configuration

### Step 1: Add Component to Page

1. Navigate to any Lightning record page
2. Click ⚙️ **Edit Page**
3. Find **"Data Cloud Multi-Column Card"** in Custom components
4. Drag onto page

### Step 2: Configure Columns

Each column requires these properties:

| Property | Example | Description |
|----------|---------|-------------|
| **Label** | "Drug" | Display name for this column |
| **DMO Name** | `Drug_Data_Unified__dlm` | Data Cloud object API name |
| **DMO Search Field** | `CRG_Drug_Id_Text__c` | Field to query in Data Cloud |
| **DMO Display Field** | `Drug_Name__c` | Field to display from Data Cloud |
| **SObject Search Field** | `GlobalData_Drug__r.DrugID_Text__c` | Field from current record to use as search value |
| **SObject Display Field** | `Drug_Brand_Name__c` | Field from current record to display |

**Optional Settings:**
- **Invalid Values**: Comma-separated values that trigger custom message (e.g., `"Not Found,N/A"`)
- **No Data Message**: Custom message when data is missing
- **Hide When Invalid**: Checkbox to hide entire column if data is blank

### Step 3: Save & Activate

Click **Save** → **Activate** → Choose page assignment

---

## 📖 Example Configuration

### Drug + Bundle + Parent Account

**Column 1 - Drug:**
```
Label: Drug
DMO Name: Drug_Data_Unified__dlm
DMO Search Field: CRG_Drug_Id_Text__c
DMO Display Field: Drug_Name__c
SObject Search Field: GlobalData_Drug__r.DrugID_Text__c
SObject Display Field: Drug_Brand_Name__c
Invalid Values: Drug not found,Invalid Drug
No Data Message: No drug assigned.
```

**Column 2 - Bundle:**
```
Label: Bundle
DMO Name: Bundle_Data_Unified__dlm
(configure similarly)
```

**Column 3 - Parent Account:**
```
Label: Parent Account
DMO Name: UnifiedssotAccountAcct__dlm
Use CDP Page: ✅ (checked)
(configure similarly)
```

---

## 🛠️ Requirements

- **Salesforce Edition**: Enterprise, Unlimited, or Developer
- **Data Cloud**: Must be enabled in your org
- **API Version**: 66.0 or higher
- **Permissions**:
  - User: Customize Application permission
  - User: Read access to Data Cloud objects
  - Admin: Deploy Lightning Web Components & Apex

---

## 🧪 Testing

The package includes comprehensive test coverage:

```bash
# Run all tests
sfdx force:apex:test:run -n DataCloudRelatedFieldControllerTest -u MyOrg -r human

# Expected output:
# ✅ testGetDrugRecords_BlankInputs - PASS
# ✅ testGetDrugRecords_ValidInputs_NoDisplayField - PASS
# ✅ testGetDrugRecords_ValidInputs_WithDisplayField - PASS
# ✅ testGetDrugRecords_ExceptionHandling - PASS
#
# Test Coverage: ~90%+
```

---

## 🐛 Troubleshooting

### Component not visible in App Builder
- Verify deployment was successful: `sfdx force:source:deploy:report`
- Hard refresh browser: `Ctrl+Shift+R` (Windows) or `Cmd+Shift+R` (Mac)
- Check `isExposed=true` in metadata file

### "Class Not Found" Error
- Ensure Apex class deployed successfully
- Check for namespace conflicts
- Re-deploy: `sfdx force:source:deploy -p force-app`

### Data Not Loading
- Verify DMO object name is correct (check Data Cloud UI)
- Confirm user has FLS permissions on all fields
- Check browser console for JavaScript errors
- Verify search field contains valid data

### Links Not Working
- Check DMO Name matches exactly (case-sensitive)
- For Unified Account, enable "Use CDP Page for Parent Account"
- Verify record IDs are valid

---

## 📚 Documentation

- **[Deployment Guide](./DEPLOYMENT_GUIDE.md)** - Detailed deployment steps
- **[Package Summary](./PACKAGE_SUMMARY.md)** - Component inventory & relationships
- **[Checklist](./CHECKLIST.md)** - Pre/post deployment checklist

---

## 🤝 Contributing

Contributions are welcome! This is an open-source unmanaged package.

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

---

## 🙏 Acknowledgments

- Built with [Lightning Web Components](https://developer.salesforce.com/docs/component-library/documentation/en/lwc)
- Designed for [Salesforce Data Cloud](https://www.salesforce.com/products/data-cloud/overview/)
- Inspired by the Salesforce community

---

## 📧 Support

- **Issues**: [GitHub Issues](https://github.com/ekurawle/datacloud-360-components/issues)
- **Questions**: [Salesforce Stack Exchange](https://salesforce.stackexchange.com/)
- **Discussions**: [Trailblazer Community](https://trailblazers.salesforce.com/)

---

## ⭐ Star Us!

If this package helped you, please give it a ⭐ star on GitHub!

---

**Made with ❤️ for the Salesforce Community**

[![Salesforce](https://img.shields.io/badge/Salesforce-00A1E0?style=for-the-badge&logo=salesforce&logoColor=white)](https://www.salesforce.com/)
[![Data Cloud](https://img.shields.io/badge/Data%20Cloud-00A1E0?style=for-the-badge&logo=salesforce&logoColor=white)](https://www.salesforce.com/products/data-cloud/overview/)
