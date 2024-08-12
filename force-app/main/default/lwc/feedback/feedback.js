import { LightningElement, api, wire, track } from 'lwc';
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
    @track contributionids =[]
        
        @track horizontalFields = [];
        @track verticalFields = [];
        @track detailFields = [];
        @track feedbackFields = [];
        
      

    @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$horizontalFieldSet' })
    wiredHorizontalFields({ error, data }) {
        if (data) {
            this.horizontalFields = data;
           // console.log(JSON.stringify(this.horizontalFields));
        } else if (error) {
           // console.error('Error fetching horizontal fields:', error);
        }
    }
    
    @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$verticalFieldSet' })
    wiredVerticalFields({ error, data }) {
        if (data) {
            this.verticalFields = data;
           // console.log('vertical feedback latest '+JSON.stringify(this.verticalFields));
        } else if (error) {
           // console.error('Error fetching vertical fields:', error);
        }
    }
    
    @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$detailFieldSet' })
    wiredDetailFields({ error, data }) {
        if (data) {
            this.detailFields = data;
           // console.log('details '+JSON.stringify(this.detailFieldSet));
        } else if (error) {
           // console.error('Error fetching detail fields:', error);
        }
    }
    
    feedbackList;
    error;
    column;
    @wire(getRecordFeedback)
    wiredFeedback({ error, data }) {
        if (data) {
           // console.log('Wrapper data feedback:'+JSON.stringify(data));
            this.feedbackList = data;
           // console.log('feedlist List-> '+JSON.stringify(this.feedbackList));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.feedbackList = undefined;
        }
    }
    handleRefresh() {
       // console.log('refresh');
        refreshApex(this.wiredFeedback);
    }
    @track count = 0;
    countrecord(){
        const uniqueIds = new Set();
        
        if (this.feedbackList) {
            this.feedbackList.forEach(element => {
                uniqueIds.add(element.Id);
            });
        }
        
        this.count = uniqueIds.size;
       // console.log('Unique record count: ' + this.count);
    }
   
}
