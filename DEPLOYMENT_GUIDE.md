# Deployment Guide - Data Cloud 360 Components

## Package Contents

This unmanaged package contains:

### Lightning Web Components (2)
1. **dataCloudMultiColumnCard** - Main component (exposed to App Builder)
2. **dataCloudRelatedField** - Child component (internal use)

### Apex Classes (2)
1. **DataCloudRelatedFieldController** - Controller for Data Cloud queries
2. **DataCloudRelatedFieldControllerTest** - Test class (provides code coverage)

## Pre-Deployment Checklist

- [ ] Salesforce org has Data Cloud enabled
- [ ] User has permission to create/deploy Apex classes and LWC components
- [ ] SFDX CLI installed (for command-line deployment)
- [ ] Target org authenticated with SFDX

## Deployment Methods

### Method 1: SFDX Command Line (Recommended)

```bash
# Navigate to package directory
cd package-datacloud360

# Authenticate to your org (if not already)
sfdx auth:web:login -a MyOrgAlias

# Deploy all components
sfdx force:source:deploy -p force-app -u MyOrgAlias

# Verify deployment
sfdx force:source:deploy:report
```

### Method 2: Deploy Using Manifest

```bash
# Deploy using package.xml
sfdx force:source:deploy -x manifest/package.xml -u MyOrgAlias
```

### Method 3: VS Code Extension

1. Right-click on `force-app` folder
2. Select "SFDX: Deploy Source to Org"
3. Choose your target org

### Method 4: Change Sets (UI-based)

1. Deploy to source org first (using Method 1, 2, or 3)
2. Go to Setup > Deployment Settings
3. Create Outbound Change Set
4. Add components:
   - LightningComponentBundle: dataCloudMultiColumnCard
   - LightningComponentBundle: dataCloudRelatedField
   - ApexClass: DataCloudRelatedFieldController
   - ApexClass: DataCloudRelatedFieldControllerTest
5. Upload and deploy to target org

### Method 5: Create Unmanaged Package

1. Deploy to a packaging org
2. Setup > Apps > Package Manager
3. Click "New" to create package:
   - Package Name: `Data Cloud 360 Components`
   - Description: `Components for displaying Data Cloud records in multi-column card`
4. Add components (use "Add" button):
   - Select all LWC components
   - Select all Apex classes
5. Click "Upload" to create package version
6. Share install URL with users

## Post-Deployment Steps

### 1. Run Test Class
```bash
# Run tests
sfdx force:apex:test:run -n DataCloudRelatedFieldControllerTest -u MyOrgAlias -r human
```

### 2. Verify Component Installation
```bash
# Query for LWC bundles
sfdx force:data:soql:query -q "SELECT DeveloperName, MasterLabel FROM LightningComponentBundle WHERE DeveloperName IN ('dataCloudMultiColumnCard', 'dataCloudRelatedField')" -u MyOrgAlias
```

### 3. Grant User Permissions

Users need these permissions:
- **View Setup and Configuration** (to see components in App Builder)
- **Customize Application** (to add components to pages)
- **Read access** to Data Cloud objects being queried

### 4. Add Component to a Page

1. Navigate to any record page (e.g., Account, Opportunity)
2. Click Setup gear > Edit Page
3. Find "Data Cloud Multi-Column Card" in component list (under "Custom")
4. Drag onto page
5. Configure properties in right panel
6. Click "Save" then "Activate"

## Component Configuration Example

### Example: Drug & Parent Account Display

**Column 1 - Drug:**
- Label: `Drug`
- DMO Name: `Drug_Data_Unified__dlm`
- DMO Search Field: `CRG_Drug_Id_Text__c`
- DMO Display Field: `Drug_Name__c`
- SObject Search Field: `GlobalData_Drug__r.DrugID_Text__c`
- SObject Display Field: `Drug_Brand_Name__c`
- Invalid Values: `Drug not found,Invalid Drug`
- No Data Message: `No drug assigned.`

**Column 2 - Bundle:**
- Label: `Bundle`
- DMO Name: `Bundle_Data_Unified__dlm`
- (Configure other fields similarly)

**Column 3 - Parent Account:**
- Label: `Parent Account`
- DMO Name: `UnifiedssotAccountAcct__dlm`
- Use CDP Page: `Yes` (checked)
- (Configure other fields similarly)

## Troubleshooting

### Component Not Visible in App Builder
- Verify deployment was successful
- Check `isExposed=true` in metadata file
- Refresh browser cache (Ctrl+Shift+R)

### "Class Not Found" Error
- Run deployment again
- Verify Apex class deployed successfully
- Check for namespace conflicts

### Data Not Loading
- Verify DMO object name is correct
- Check user has FLS permissions on fields
- Verify search field contains valid data
- Check browser console for JavaScript errors

### Test Class Failures
- Ensure test data setup is valid
- Check field-level security on test objects
- Verify CRUD permissions

## Rollback Instructions

### Remove Components via SFDX
```bash
# Delete from org
sfdx force:source:delete -p force-app -u MyOrgAlias --noprompt
```

### Remove Components via UI
1. Setup > Custom Code > Lightning Components
2. Delete both LWC components
3. Setup > Custom Code > Apex Classes
4. Delete both Apex classes

## Support & Modifications

Since this is an **unmanaged package**, you can modify components after installation:
- Edit component code directly in target org
- No upgrade path from original package
- Changes won't be overwritten by package updates

## Version History

- **v1.0.0** - Initial release
  - dataCloudMultiColumnCard
  - dataCloudRelatedField
  - DataCloudRelatedFieldController
  - Full test coverage included
