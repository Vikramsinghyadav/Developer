import { LightningElement, api, wire } from 'lwc';
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
    contributionids =[]
 
        feedbackFields = [];
        
        @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$feedbackFieldSet'})
        wiredFeedbackFields({ error, data }) {
            if (data) {
                this.feedbackFields = data;
            } else if (error) {
                console.error('Error fetching feedback fields:', error);
            }
        }

   
    
    feedbackList;
    error;
    column;
    recName = 'Self_feedback';
    @wire(getSelffeedbackrecord, {recordTypeName:'$recName'})
    wiredFeedback({ error, data }) {
        if (data) {
            this.feedbackList = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.feedbackList = undefined;
        }
    }
   
}
