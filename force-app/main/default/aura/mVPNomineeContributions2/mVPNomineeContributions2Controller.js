({
    doInit: function(component, event, helper) {
        console.log('fire helper recordid:'+ component.get("v.recordId"));
        helper.getContactId(component,helper);
        helper.getFieldSetFields(component);
    
    },

    handleSectionToggle: function(component, event) {
        const openSections = event.getParam('openSections');
        component.set('v.activeSections', openSections);
    }
})