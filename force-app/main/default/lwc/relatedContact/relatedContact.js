import { LightningElement,api,track} from 'lwc';
import getContacts from '@salesforce/apex/relatedContact.getContacts';
import removecontacts from '@salesforce/apex/relatedContact.deleteRecords';
import saveRecords from '@salesforce/apex/relatedContact.saveRecords';
export default class RelatedContact extends LightningElement {
    @api recordId;
     @track contactlist=[];
     hidechekbox=true;
     selectedconid=[];
     @track newContact = { FirstName: '', LastName: '', Phone: '', AccountId:''};
     ShowEdit=true;
     ShowSavebutton=false;
     @track editlabel='Edit';
     
    connectedCallback() {
        getContacts({ acid: this.recordId })
            .then(result => {
                this.wiredres=result;
                if(result.data){
                    this.contactlist = result.data;
                    

                }
                console.log('result ->'+this.contactlist);
                this.contactlist=result;
                console.log('contactlist'+JSON.stringify(this.contactlist));
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.contactlist = undefined;
            });
    }
    deleterecord(event){
        console.log('delete call '+event.target.value);
        const index = event.currentTarget.dataset.index;
        console.log('index '+index);
        if(event.target.value!=null){
        removecontacts({conid :event.target.value}).then((result) => {
            console.log('Contact deleted: ', result);
            window.location.reload();
        })
        .then(() => {
            console.log('Data refreshed after deletion');
        })
        
    }else if(index){
        this.contactlist.splice(index,1);
    }
    }
    handleSelect(event){
        const ids= event.target.dataset.index;
        if(this.selectedconid.includes(ids)){
            //this.ShowEdit=false;
            this.selectedconid.pop();
        }else{
        this.selectedconid.push(ids);
        }
        console.log('selected id->'+this.selectedconid);
    }
    
    editRow(event) {
        // Assuming this.contactlist is your existing array of contacts
this.contactlist = this.contactlist.map(contact => ({
    ...contact,
    Edit: contact.Edit !== undefined ? contact.Edit : false // Initialize Edit property if missing
}));
    console.log('list after custom property '+this.contactlist);
    this.hidechekbox = !this.hidechekbox;
    
    // Iterate through selected contacts and toggle the Edit property
    this.selectedconid.forEach((selectedId) => {
        // Find the contact in the contactlist array by matching the Id
        const contact = this.contactlist.find((item) => item.Id === selectedId);
        console.log('contact'+JSON.stringify(contact));
        console.log('contact'+JSON.stringify(contact.Edit));
        if (contact) {
            console.log('Toggling Edit property for contact with ID:', selectedId);
            if (contact.Edit == undefined) {
                contact.Edit = false;
            }else
            contact.Edit = !contact.Edit ;
            // Toggle the Edit property

            console.log(`Edit for contact with ID ${selectedId}: ${contact.Edit}`);
        } else {
            console.log(`Contact with ID ${selectedId} not found.`);
        }
    });

    // Change label based on current state
    if (this.editlabel === 'Edit') {
        this.editlabel = 'View';
    } else if (this.editlabel === 'View') {
        this.editlabel = 'Edit';

        if (confirm("Discard changes?") == true) {
            this.selectedconid = [];
            
        }
    }
}

addRow() {
    console.log('add');
    this.oldlength=this.contactlist.length;
    console.log(this.oldlength+' oldlegt '+this.contactlist.length);
    this.contactlist = [...this.contactlist, { ...this.newContact, AccountId: this.recordId, Edit: true }];

    this.areDetailsVisible = true;
    console.log('acc->'+this.contactlist.AccountId);
    
  
    if(this.oldlength<this.contactlist.length){
        console.log('true');
        this.newrow=this.contactlist.length
    }
    Edit=!true;
    
 }
handleFirstNameChange(event) {
    console.log(event.target.value + 'fnm');
const index = event.currentTarget.dataset.index;
console.log(event.target);
console.log(index + ' <-idx');
this.datassign(event.target.value,index,['FirstName']);

}

handleLastNameChange(event) {
    console.log(event.target.value + 'fnm');        
    const index = event.currentTarget.dataset.index;    
    console.log(event.target);    
    console.log(index + ' <-idx');
    console.log(event.target.value);
    this.datassign(event.target.value,index,['LastName']);
   
}
datassign(data,index,[field]){
    console.log(data+' new '+index+' f ->'+[field]);
    console.log('Data:', data);
    console.log('Index:', index);

    if (index){
        
        this.contactlist[index][field]=data;
        this.contactlist[index][field]=data;
        this.contactlist[index][field]=data;
    }else {
        console.error("Index is undefined. 2");
    }
    this.ShowSavebutton=true;
    console.log('Final contactlist2:', JSON.stringify(this.contactlist));
}

handlePhoneChange(event) {
    console.log(event.target.value + 'fnm'); 
    const index = event.currentTarget.dataset.index;
    console.log(event.target);
    console.log(index + ' <-idx');  
    this.datassign(event.target.value,index,['Phone']);  
    
}

saverecord(event) { 
    saveRecords({ listToSave: this.contactlist})
    .then(result => {
        console.log('Records saved: ', result);
        window.location.reload();
    })
    .catch(error => {
        console.error('Error saving records:', error);
        this.handleToast({ isSuccess: false, error: error.body ? error.body.message : 'An unexpected error occurred' });
    });
}
handleToast(result) {
    let title, message, variant;

    if (result && result.isSuccess) {
        title = 'Success';
        message = 'New contact saved successfully!';
        variant = 'success';

        // Additional actions for success
        this.areDetailsVisible = false;
        console.log('wiredres '+this.wiredres);
       // this.contactlist2 = [];
    } else {
        title = 'Error';
        message = result && result.error ? result.error : 'An unexpected error occurred';
        variant = 'error';
    }

    this.tostfun(title, message, variant);
}
tostfun(title, message, variant) {
    const toastEvent = new ShowToastEvent({
        title: title,
        message: message,
        variant: variant
    });
    this.dispatchEvent(toastEvent);
}
}