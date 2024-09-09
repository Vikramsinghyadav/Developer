import { LightningElement, api, wire  } from 'lwc';
import getFieldSetFields from '@salesforce/apex/FieldSetController.getFieldSetFields';
import getParent from '@salesforce/apex/DesignationController.getParent';
import getContribution from '@salesforce/apex/DesignationController.getContribution';

export default class ContributionFieldSetViewer extends LightningElement {
    @api recordId;
    @api contactId;
    activeSections=[];
    @api title = 'Contribution Details';
    @api horizontalFieldSet = 'Horizontal';
    @api verticalFieldSet = 'Vertical';
    @api detailFieldSet = 'Detail';
    @api feedbackFieldSet = 'set1';
    @api orderBy = 'ASC';
    contributionids =[]
    @wire(getParent, { recordid: '$recordId' })
        wiredContactId({ error, data }) {
            if (data) {
                this.contactId = data;
            } else if (error) {
                this.contactId = null;
            }
        }
        
        @wire(getContribution, { recordid: '$contactId' })
        wiredcontribution({ error, data }) {
            if (data) {
                this.contributionids = JSON.parse(JSON.stringify(data));
                this.activeSections = [this.contributionids[0].Id];
            } else if (error) {
                this.contributionids = null;
            }
        }
        handleSectionToggle(event) {
            const openSections = event.detail.openSections;
            this.activeSections = openSections;
        }
        horizontalFields = [];
        verticalFields = [];
        detailFields = [];
        feedbackFields = [];
        
        @wire(getFieldSetFields, { objectName: 'Feedback__c', fieldSetName: '$feedbackFieldSet'})
        wiredFeedbackFields({ error, data }) {
            if (data) {
                this.feedbackFields = data;
            } else if (error) {
                console.error('Error fetching feedback fields:', error);
            }
        }

    @wire(getFieldSetFields, { objectName: 'Contribution__c', fieldSetName: '$horizontalFieldSet' })
    wiredHorizontalFields({ error, data }) {
        if (data) {
            if(data!=null && data!=''){
            this.horizontalFields = data;
            }
        } else if (error) {
            console.error('Error fetching horizontal fields:', error);
        }
    }
    
    @wire(getFieldSetFields, { objectName: 'Contribution__c', fieldSetName: '$verticalFieldSet' })
    wiredVerticalFields({ error, data }) {
        if (data) {
            if(data!=null && data!=''){
            this.verticalFields = data;
            }
        } else if (error) {
           console.error('Error fetching vertical fields:', error);
        }
    }
    
    @wire(getFieldSetFields, { objectName: 'Contribution__c', fieldSetName: '$detailFieldSet' })
    wiredDetailFields({ error, data }) {
        if (data) {
            if(data!=null && data!=''){
            this.detailFields = data;
            }
        } else if (error) {
            console.error('Error fetching detail fields:', error);
        }
    } 
}
