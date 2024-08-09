import { LightningElement, api, wire, track } from 'lwc';
import getFieldSetFields from '@salesforce/apex/FieldSetController.getFieldSetFields';
import getParent from '@salesforce/apex/DesignationController.getParent';
import getSelffeedbackrecord from '@salesforce/apex/FeedbackController.getRecords';
import getContribution from '@salesforce/apex/DesignationController.getContribution';

export default class ContributionFieldSetViewer extends LightningElement {
    @api firstName="this is demo firstName";
    @api recordId;
    @api contactId;
    @track activeSections=[];
    @api title = 'Contribution Details';
    @api horizontalFieldSet = 'Horizontal';
    @api verticalFieldSet = 'Vertical';
    @api detailFieldSet = 'Detail';
    @api feedbackFieldSet = 'set1';
    @api orderBy = 'ASC';
    @track contributionids =[]
    @wire(getParent, { recordid: '$recordId' })
        wiredContactId({ error, data }) {
            if (data) {
                this.contactId = data;
                console.log('contact '+this.contactId);
            } else if (error) {
                console.error('Error fetching contact ID:', error);
                this.contactId = null;
            }
        }
        
        @wire(getContribution, { recordid: '$contactId' })
        wiredcontribution({ error, data }) {
            if (data) {
                console.log('Wrapper data of contributions:'+JSON.stringify(data));
                this.contributionids = JSON.parse(JSON.stringify(data));
                this.activeSections = [this.contributionids[0].Id];
                console.log('this ois cons=tribuyion'+this.contributionids);
            } else if (error) {
                console.error('Error fetching contact ID:', error);
                this.contributionids = null;
            }
        }
        handleSectionToggle(event) {
            const openSections = event.detail.openSections;
            this.activeSections = openSections;
        }
        @track horizontalFields = [];
        @track verticalFields = [];
        @track detailFields = [];
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

    @wire(getFieldSetFields, { objectName: 'Contribution__c', fieldSetName: '$horizontalFieldSet' })
    wiredHorizontalFields({ error, data }) {
        if (data) {
            this.horizontalFields = data;
            console.log(JSON.stringify(this.horizontalFields));
        } else if (error) {
            console.error('Error fetching horizontal fields:', error);
        }
    }
    
    @wire(getFieldSetFields, { objectName: 'Contribution__c', fieldSetName: '$verticalFieldSet' })
    wiredVerticalFields({ error, data }) {
        if (data) {
            this.verticalFields = data;
        } else if (error) {
            console.error('Error fetching vertical fields:', error);
        }
    }
    
    @wire(getFieldSetFields, { objectName: 'Contribution__c', fieldSetName: '$detailFieldSet' })
    wiredDetailFields({ error, data }) {
        if (data) {
            this.detailFields = data;
            console.log('details '+JSON.stringify(this.detailFieldSet));
        } else if (error) {
            console.error('Error fetching detail fields:', error);
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
