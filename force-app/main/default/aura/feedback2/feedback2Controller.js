({
    doInit: function (component, event, helper) {
       

        // Fetch Feedback records
        var action2 = component.get("c.getRecordFeedback");
        action2.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('selffeedback data  '+response.getReturnValue());
                component.set("v.feedbackList", response.getReturnValue());
                console.log('Feedback List: ' + JSON.stringify(response.getReturnValue()));
            } else if (state === "ERROR") {
                component.set("v.error", response.getError());
                component.set("v.feedbackList", []);
            }
        });
        $A.enqueueAction(action2);
    }
     // Fetch Feedback fields
       /* var action1 = component.get("c.getFieldSetFields");
        action1.setParams({
            objectName: 'Feedback__c',
            fieldSetName: component.get("v.feedbackFieldSet")
        });

        action1.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('selffeedback fieldset'+response.getReturnValue());
                component.set("v.feedbackFields", response.getReturnValue());
                console.log('Feedback fields: ' + JSON.stringify(response.getReturnValue()));
            } else if (state === "ERROR") {
                console.error('Error fetching feedback fields:', response.getError());
            }
        });
        $A.enqueueAction(action1);*/
})