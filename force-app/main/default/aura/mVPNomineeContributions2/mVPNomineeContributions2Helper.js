({
    getContactId: function(component, helper) {
        const action = component.get("c.getParent");
        action.setParams({ recordid: component.get("v.recordId") });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === 'SUCCESS') {
                const contactId = response.getReturnValue();
                component.set("v.contactId", contactId);
                helper.getContribution(component);
            } else {
                console.error('Error fetching contact ID:', response.getError());
            }
        });
        $A.enqueueAction(action);
    },
    
    getContribution: function(component) {
        const contactId = component.get("v.contactId");
        
        if (contactId) {
            const action = component.get("c.getContribution");
            action.setParams({ recordid: contactId });
            action.setCallback(this, function(response) {
                const state = response.getState();
                if (state === 'SUCCESS') {
                    const contributionIds = response.getReturnValue();
                    component.set('v.contributionids', contributionIds);
                    component.set('v.activeSections', [contributionIds[0].Id]);
                    helper.getFieldSetFields(component);
                } else {
                    console.error('Error fetching contribution IDs:', response.getError());
                }
            });
            $A.enqueueAction(action);
        } else {
            console.warn('Contact ID is undefined, skipping getContribution.');
        }
    }, getFieldSetFields: function(component) {
        const fieldSets = ['Horizontal', 'verticalFieldSet', 'detailFieldSet', 'feedbackFieldSet'];
        fieldSets.forEach(fieldSet => {
            const action = component.get('c.getFieldSetFields');
            action.setParams({ objectName: 'Contribution__c', fieldSetName: fieldSet });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === 'SUCCESS') {
                component.set('v.' + fieldSet.replace('FieldSet', 'Fields'), response.getReturnValue());
            } else {
                console.error('Error fetching fields:', response.getError());
            }
        });
        $A.enqueueAction(action);
    });
}
})