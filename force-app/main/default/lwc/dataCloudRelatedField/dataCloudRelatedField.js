import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import getDrugRecords from '@salesforce/apex/DataCloudRelatedFieldController.getDrugRecords';

export default class DataCloudRelatedField extends LightningElement {
    @api recordId;
    @api objectApiName;
    @api useCdpPageForParentAccount = false;

    // App Builder Properties
    @api dmoName;
    @api dmoSearchField;
    @api dmoDisplayField;
    @api sobjectSearchField;
    @api displayField;
    @api fieldLabel;

    // NEW: Filter Logic Properties
    @api noDataMessage;
    @api invalidValues;

    @track records = [];
    isLoading = true;
    error;

    // Build the field string for UI Record API
    get dynamicFields() {
        // Prevent the wire from firing before properties fully load
        if (!this.objectApiName || !this.sobjectSearchField || !this.displayField) {
            return undefined;
        }

        let fields = [];
        fields.push(`${this.objectApiName}.${this.displayField}`);
        fields.push(`${this.objectApiName}.${this.sobjectSearchField}`);
        return fields;
    }

    // NEW: Get the actual text value of the Search field (e.g., GlobalData_Drug__r.DrugID_Text__c)
    get crmSearchValue() {
        if (this.currentRecord && this.currentRecord.data && this.sobjectSearchField) {
            const fieldPath = `${this.objectApiName}.${this.sobjectSearchField}`;
            return getFieldValue(this.currentRecord.data, fieldPath);
        }
        return null;
    }

    // STEP 1: Fetch the CRM Record
    @wire(getRecord, { recordId: '$recordId', fields: '$dynamicFields' })
    wiredRecord(result) {
        this.currentRecord = result;

        if (result.data) {
            // 1. Tell the parent if we should hide
            this.dispatchEvent(new CustomEvent('statuschange', {
                detail: { hide: this.isInvalid }
            }));

            // 2. Fetch DMO Data Imperatively (Faster and more reliable on heavy pages)
            if (!this.isInvalid) {
                this.fetchDmoData();
            } else {
                this.isLoading = false;
            }
        } else if (result.error) {
            this.error = 'Error loading CRM record';
            this.isLoading = false;
        }
    }

    // Helper to get the actual text value from the CRM record
    get crmDisplayValue() {
        if (this.currentRecord && this.currentRecord.data) {
            const fieldPath = `${this.objectApiName}.${this.displayField}`;
            return getFieldValue(this.currentRecord.data, fieldPath);
        }
        return null;
    }

    // NEW LOGIC: Should we abort the DMO query?
    get isInvalid() {
        // Wait until the record actually loads before evaluating
        if (!this.currentRecord || !this.currentRecord.data) return false;

        const displayVal = this.crmDisplayValue;
        const searchVal = this.crmSearchValue;

        if (!displayVal || !searchVal) return true;

        if (this.invalidValues) {
            const invalidArray = this.invalidValues.split(',').map(s => s.trim().toLowerCase());
            if (invalidArray.includes(displayVal.toLowerCase())) {
                return true;
            }
        }

        return false;
    }

    // STEP 2: Fetch DMO Data Imperatively
    // This replaces the @wire(getDrugRecords) to prevent race conditions
    fetchDmoData() {
        this.isLoading = true;

        getDrugRecords({
            searchValue: this.crmSearchValue,
            dmoName: this.dmoName,
            dmoSearchField: this.dmoSearchField,
            dmoDisplayField: this.dmoDisplayField
        })
        .then(data => {
            this.records = data;
            this.error = undefined;
            this.isLoading = false;
        })
        .catch(error => {
            this.error = error.body ? error.body.message : 'Unknown error occurred';
            this.records = [];
            this.isLoading = false;
        });
    }

    get hasRecords() {
        return this.records && this.records.length > 0;
    }

    /*
    get recordUrl() {
        //return this.hasRecords ? `/lightning/r/${this.dmoName}/${this.records[0].Id}/view` : '';
        if (!this.hasRecords) return '';

        // Special routing for Unified Account DMO
        if (this.dmoName === 'UnifiedssotAccountAcct__dlm') {
            return `/lightning/cdp/${this.dmoName}/${this.records[0].Id}/view`;
        }

        // Standard Salesforce routing for everything else (Drug, Bundle, etc.)
        return `/lightning/r/${this.dmoName}/${this.records[0].Id}/view`;
    }*/

    get recordUrl() {
        if (!this.hasRecords) return '';

        if (this.useCdpPageForParentAccount && this.dmoName === 'UnifiedssotAccountAcct__dlm') {
            return `/lightning/cdp/${this.dmoName}/${this.records[0].Id}/view`;
        }

        return `/lightning/r/${this.dmoName}/${this.records[0].Id}/view`;
    }




    get recordName() {
        if (!this.hasRecords) return '';

        if (this.dmoDisplayField && this.records[0][this.dmoDisplayField]) {
            return this.records[0][this.dmoDisplayField];
        }

        return this.crmDisplayValue;
    }
}
