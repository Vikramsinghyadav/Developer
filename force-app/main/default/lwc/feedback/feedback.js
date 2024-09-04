import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getFieldSetFields from '@salesforce/apex/FieldSetController.getFieldSetFields';
import getRecordFeedback from '@salesforce/apex/FeedbackController.getRecordFeedback';

export default class ContributionFieldSetViewer extends LightningElement {
    @api recordId;
    @api contactId;
    @api title = 'Contribution Details';
    @api horizontalFieldSet = 'horizontal';
    @api verticalFieldSet = 'vertical';
    @api detailFieldSet = 'detail';
    @api feedbackFieldSet = 'set1';
    @api orderBy = 'ASC';
    
    contributionids = [];
    
    horizontalFields = [];
    verticalFields = [];
    detailFields = [];
    feedbackFields = [];
    
    @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$horizontalFieldSet' })
    wiredHorizontalFields({ error, data }) {
        if (data) {
            this.horizontalFields = data;
        } else if (error) {
            console.error('Error fetching horizontal fields:', error);
        }
    }

    @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$verticalFieldSet' })
    wiredVerticalFields({ error, data }) {
        if (data) {
            this.verticalFields = data;
        } else if (error) {
            console.error('Error fetching vertical fields:', error);
        }
    }

    @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$detailFieldSet' })
    wiredDetailFields({ error, data }) {
        if (data) {
            this.detailFields = data;
        } else if (error) {
            console.error('Error fetching detail fields:', error);
        }
    }

    feedbackList;
    error;
    column;
    recName = 'Feedback';
    
    @wire(getRecordFeedback, { recordTypeName: '$recName' })
    wiredFeedback({ error, data }) {
        if (data) {
            this.feedbackList = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.feedbackList = undefined;
        }
    }

    handleRefresh() {
        refreshApex(this.wiredFeedback);
    }

    count = 0;

    countrecord() {
        const uniqueIds = new Set();
        
        if (this.feedbackList) {
            this.feedbackList.forEach(element => {
                uniqueIds.add(element.Id);
            });
        }
        
        this.count = uniqueIds.size;
    }
}
