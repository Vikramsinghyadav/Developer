import { LightningElement, api,track ,wire} from 'lwc';
import getFieldSetFields from '@salesforce/apex/FieldSetController.getFieldSetFields';
import getFieldSetData from '@salesforce/apex/FieldSetController.getFieldSetData';
import getParent from '@salesforce/apex/DesignationController.getParent';


export default class MVPNomineeBasicInfo extends LightningElement {
    @track fields=[];
    @track error;
    @api column;
    
    @api filedsetname;
    @api objectApiName;
    @api recordId;
    @track contactData;
    @track contactId;
    @api title = 'Basic Info';
    @api showHeader;

    @wire(getFieldSetFields, { objectName: 'Contact', fieldSetName: '$filedsetname' })
    wiredFieldSet({ error, data }) {
        if (data) {
            this.fields = data;
           // console.log('fields'+JSON.stringify(this.fields));
            this.countAndCalculateAverage();
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.fields = undefined;
        }
    }
    @track average=0;
    fieldsetdata;
    countAndCalculateAverage() {
        let sum = 0;
        let count = 0;
    
        if (this.fields) {
            this.fields.forEach(element => {
               // console.log('Processing element: ', element);
                if(element=='Feedback_Rating_Count__c'){
                    let currentfield=element;
                    getFieldSetData({ fieldSetName: element })
                    .then(data => {
                        if (data) {
                            this.fieldsetdata = data;
                           // console.log('fields ka data'+JSON.stringify(this.fieldsetdata));
                            if (this.fieldsetdata && this.fieldsetdata.length > 0) {
                                this.fieldsetdata.forEach(record => {
                                   // console.log('Processing record: ', record);
                                    if (record.Feedback_Rating_Count__c) {
                                        sum += record.Feedback_Rating_Count__c;
                                        count++;
                                    }
                                });
                            }
                    
                            this.average = count > 0 ? sum / count : 0;
                    
                           // console.log('Sum of Feedback_Rating_Count__c: ' + sum);
                            //console.log('Record count: ' + count);
                            //console.log('Average Feedback_Rating_Count__c: ' + this.average);
                           
                        } else if (error) {
                            this.error = error;
                            this.fields = undefined;
                        }
                    });
              
                }
                 
                
            });
        }
       
    }
    
   
        @wire(getParent, { recordid: '$recordId' })
        wiredContactId({ error, data }) {
            if (data) {
                this.contactId = data;
               // console.log(this.contactId);
            } else if (error) {
               // console.error('Error fetching contact ID:', error);
                this.contactId = null;
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
