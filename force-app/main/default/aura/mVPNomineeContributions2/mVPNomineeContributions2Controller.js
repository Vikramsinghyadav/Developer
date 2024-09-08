({
    doInit: function(component, event, helper) {
        helper.getContactId(component,helper);
        helper.getFieldSetFields(component);
    },

    handleSectionToggle: function(component, event) {
        const openSections = event.getParam('openSections');
        component.set('v.activeSections', openSections);
    }
})