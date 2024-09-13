({
    fetchFieldSetFields : function(component) {
        let action = component.get("c.getFieldSet");
        action.setParams({
            objectName: component.get("v.objectApiName"),
            fieldSetName: component.get("v.filedsetname")
        });
        
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.fields", response.getReturnValue());
                
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set("v.error", errors[0].message);
                    }
                } else {
                    component.set("v.error", "Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    
    fetchParentContactId : function(component) {
        let action = component.get("c.getParent");
        action.setParams({
            recordid: component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                
                component.set("v.contactId", response.getReturnValue());
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.error('Error fetching contact ID:', errors[0].message);
                    }
                } else {
                    console.error('Unknown error');
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    fetchFieldSetData : function(component) {
        let action = component.get("c.getContactData");
        action.setParams({
        recordid: component.get("v.recordId"),
        });
        
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.averageRating", response.getReturnValue());
                
            } else if (state === "ERROR") {
                let errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set("v.error", errors[0].message);
                    }
                } else {
                    component.set("v.error", "Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
})