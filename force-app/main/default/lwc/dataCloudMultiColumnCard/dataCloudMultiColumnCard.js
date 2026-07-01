import { LightningElement, api } from 'lwc';

export default class DataCloudMultiColumnCard extends LightningElement {
    @api recordId;
    @api objectApiName;
    col2Visible = true;
    col3Visible = true;

    // Column 1
    @api col1_Label; @api col1_dmoName; @api col1_dmoSearchField;
    @api col1_dmoDisplayField; @api col1_sobjectSearchField; @api col1_displayField;
    @api col1_invalidValues; @api col1_noDataMessage; @api col1_hideWhenInvalid;

    // Column 2
    @api col2_Label; @api col2_dmoName; @api col2_dmoSearchField;
    @api col2_dmoDisplayField; @api col2_sobjectSearchField; @api col2_displayField;
    @api col2_invalidValues; @api col2_noDataMessage; @api col2_hideWhenInvalid;

    // Column 3
    @api col3_Label; @api col3_dmoName; @api col3_dmoSearchField;
    @api col3_dmoDisplayField; @api col3_sobjectSearchField; @api col3_displayField;
    @api col3_invalidValues; @api col3_noDataMessage; @api col3_hideWhenInvalid;
    @api useCdpPageForParentAccount;

    handleColStatus(event) {
    const colNum = event.target.dataset.col;
    const shouldHide = event.detail.hide;

    if (colNum === '2') {
        this.col2Visible = !shouldHide;
    } else if (colNum === '3') {
        this.col3Visible = !shouldHide;
    }
}
}
