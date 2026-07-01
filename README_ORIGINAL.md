# Data Cloud 360 Components Package

An unmanaged package containing Lightning Web Components for displaying Data Cloud (formerly CDP) related records in a multi-column card layout.

## Components

### 1. dataCloudMultiColumnCard
**Master Label**: Data Cloud Multi-Column Card  
**API Name**: `dataCloudMultiColumnCard`

A configurable 3-column card component that can be added to record pages, app pages, or home pages. Each column displays a related Data Cloud record with a clickable link.

**Features**:
- Up to 3 configurable columns
- Dynamic show/hide behavior based on data validity
- Configurable labels, DMO objects, search fields, and display fields
- Support for CDP page routing (for Unified Account records)
- Invalid value filtering with custom messages

### 2. dataCloudRelatedField
**Master Label**: Data Cloud Related Field  
**API Name**: `dataCloudRelatedField`

A child component used by `dataCloudMultiColumnCard` to display a single related Data Cloud record field. Handles data fetching, loading states, and error handling.

**Features**:
- Displays a single related Data Cloud record
- Shows loading spinner during data fetch
- Handles invalid/missing data gracefully
- Supports custom "no data" messages
- Emits status change events to parent

### 3. DataCloudRelatedFieldController
**Type**: Apex Class  
**API Name**: `DataCloudRelatedFieldController`

Server-side controller that queries Data Cloud objects dynamically using SOQL.

**Methods**:
- `getDrugRecords(String searchValue, String dmoName, String dmoSearchField, String dmoDisplayField)`: Cacheable method that returns matching Data Cloud records

## Installation

### Option 1: Deploy via SFDX CLI
```bash
cd package-datacloud360
sfdx force:source:deploy -p force-app -u your-org-alias
```

### Option 2: Create Unmanaged Package
1. Deploy components to your packaging org
2. Go to Setup > Apps > Package Manager
3. Create a new package named "Data Cloud 360 Components"
4. Add all components:
   - dataCloudMultiColumnCard (LWC)
   - dataCloudRelatedField (LWC)
   - DataCloudRelatedFieldController (Apex Class)
   - DataCloudRelatedFieldControllerTest (Apex Class)
5. Upload the package

## Usage

1. Navigate to a record page in Lightning App Builder
2. Drag the **Data Cloud Multi-Column Card** component onto the page
3. Configure each column with:
   - **Label**: Display label for the field
   - **DMO Name**: Data Cloud object API name (e.g., `Drug_Data_Unified__dlm`)
   - **DMO Search Field**: Field to search in Data Cloud
   - **DMO Display Field**: Field to display from Data Cloud record
   - **SObject Search Field**: Field from current record to use as search value
   - **SObject Display Field**: Field from current record to display
   - **Invalid Values**: Comma-separated values that should show custom message
   - **No Data Message**: Message to show when data is invalid/missing
   - **Hide Entirely if Blank**: Whether to hide the column if no data

## Component Naming

These components were renamed from their original implementation:
- `data360Card` → `dataCloudMultiColumnCard`
- `drug360RelatedListWithoutHeader` → `dataCloudRelatedField`
- `Drug360Controller` → `DataCloudRelatedFieldController`

The new names better reflect the generic Data Cloud functionality rather than being drug-specific.

## API Version

All components use API version **66.0**

## License

This is an unmanaged package and can be modified after installation.
