import { LightningElement, api, wire, track } from 'lwc';
import getFieldSetFields from '@salesforce/apex/FieldSetController.getFieldSetFields';
import getSelffeedbackrecord from '@salesforce/apex/FeedbackController.getRecordFeedback';


export default class ContributionFieldSetViewer extends LightningElement {
    @api recordId;
    @api contactId;
    @api title = 'Contribution Details';
    @api horizontalFieldSet = 'Horizontal';
    @api verticalFieldSet = 'Vertical';
    @api detailFieldSet = 'Detail';
    @api feedbackFieldSet = 'set1';
    @api orderBy = 'ASC';
    @track contributionids =[]
 
        @track feedbackFields = [];
        
        @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$feedbackFieldSet'})
        wiredFeedbackFields({ error, data }) {
            if (data) {
                this.feedbackFields = data;
                console.log('feedback set1 '+JSON.stringify(this.feedbackFields));
            } else if (error) {
                console.error('Error fetching feedback fields:', error);
            }
        }

   
    
    feedbackList;
    error;
    column;
    @wire(getSelffeedbackrecord)
    wiredFeedback({ error, data }) {
        if (data) {
            this.feedbackList = data;
            console.log('feedlist-> '+JSON.stringify(this.feedbackList));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.feedbackList = undefined;
        }
    }
   
}
