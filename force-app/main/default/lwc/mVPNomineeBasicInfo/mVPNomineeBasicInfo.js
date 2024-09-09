import { LightningElement, api, wire } from 'lwc';
import getFieldSetFields from '@salesforce/apex/FieldSetController.getFieldSetFields';
import getContactData from '@salesforce/apex/FieldSetController.getContactData';
import getParent from '@salesforce/apex/DesignationController.getParent';

export default class MVPNomineeBasicInfo extends LightningElement {
    fields = [];
    error;

    @api column;
    @api filedsetname;
    @api objectApiName;
    @api recordId;
    contactData;
    contactId;
    @api title = 'Basic Info';
    @api showHeader;

    @wire(getFieldSetFields, { objectName: 'Contact', fieldSetName: '$filedsetname' })
    wiredFieldSet({ error, data }) {
        if (data) {
            this.fields = data;
            this.countAndCalculateAverage();
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.fields = undefined;
        }
    }

    average = 0;
    fieldsetdata;

    countAndCalculateAverage() {
                        getContactData({ recordid: this.recordId })
                        .then(data => {
                            if (data) {
                                
                                this.average=data
                            }
                        });
    }

    @wire(getParent, { recordid: '$recordId' })
    wiredContactId({ error, data }) {
        if (data) {
            this.contactId = data;
        } else if (error) {
            console.error(error);
        }
    }

    get headerClass() {
        return this.showHeader ? 'slds-card__header' : 'slds-hide';
    }

    get columnCount() {
        return this.columnView;
    }

    get contactFields() {
        return this.fields;
    }
}
