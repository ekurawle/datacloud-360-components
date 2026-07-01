# ☁️ Data Cloud 360 Components

> A powerful Lightning Web Component package for displaying Salesforce Data Cloud (CDP) records in a beautiful, configurable multi-column card layout.

[![Salesforce API](https://img.shields.io/badge/Salesforce%20API-v66.0-blue.svg)](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![LWC](https://img.shields.io/badge/LWC-Lightning%20Web%20Components-orange.svg)](https://developer.salesforce.com/docs/component-library/documentation/en/lwc)

---

## 📸 Preview

```
┌─────────────────────────────────────────────────────────────┐
│  🗺️  Data 360                                                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  Drug              Bundle              Parent Account       │
│  ─────────         ─────────          ─────────            │
│  🔗 Aspirin        🔗 Pain Relief     🔗 Acme Corp         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

**Features:**
- ✅ Up to 3 configurable columns
- ✅ Dynamic show/hide based on data validity
- ✅ Clickable links to Data Cloud records
- ✅ Loading states & error handling
- ✅ Mobile responsive
- ✅ No-code configuration in App Builder

---

## 🚀 Quick Install

### Option 1: Deploy with SFDX (Recommended)

```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/datacloud-360-components.git
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
git clone https://github.com/YOUR_USERNAME/datacloud-360-components.git
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

| Component | Type | Description |
|-----------|------|-------------|
| **dataCloudMultiColumnCard** | LWC | Main component (drag-and-drop in App Builder) |
| **dataCloudRelatedField** | LWC | Child component (renders each column) |
| **DataCloudRelatedFieldController** | Apex | Server-side controller for querying Data Cloud |
| **DataCloudRelatedFieldControllerTest** | Apex | Test class with full coverage |

---

## 🎯 Use Cases

- **Healthcare**: Display Patient → Provider → Facility relationships
- **Pharma**: Show Drug → Bundle → Parent Account links
- **Retail**: Display Product → Category → Manufacturer data
- **Financial Services**: Show Account → Household → Portfolio
- **Any Industry**: Generic Data Cloud object relationships

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

- **Issues**: [GitHub Issues](https://github.com/YOUR_USERNAME/datacloud-360-components/issues)
- **Questions**: [Salesforce Stack Exchange](https://salesforce.stackexchange.com/)
- **Discussions**: [Trailblazer Community](https://trailblazers.salesforce.com/)

---

## ⭐ Star Us!

If this package helped you, please give it a ⭐ star on GitHub!

---

**Made with ❤️ for the Salesforce Community**

[![Salesforce](https://img.shields.io/badge/Salesforce-00A1E0?style=for-the-badge&logo=salesforce&logoColor=white)](https://www.salesforce.com/)
[![Data Cloud](https://img.shields.io/badge/Data%20Cloud-00A1E0?style=for-the-badge&logo=salesforce&logoColor=white)](https://www.salesforce.com/products/data-cloud/overview/)
