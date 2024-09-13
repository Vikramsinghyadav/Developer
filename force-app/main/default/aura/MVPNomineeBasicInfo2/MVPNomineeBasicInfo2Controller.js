({
    doInit : function(component, event, helper) {
        helper.fetchFieldSetFields(component);
        
        helper.fetchParentContactId(component);
        helper.fetchFieldSetData(component);
    }
})