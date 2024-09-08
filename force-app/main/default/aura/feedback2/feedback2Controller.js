({
    doInit: function (component, event, helper) {
       

        // Fetch Feedback records
        var action2 = component.get("c.getRecordFeedback");
        
        // Get the recordTypeName from the component (you can set this in your component or controller)
        var recordTypeName = component.get("v.recordTypeName");
        
        // Set the parameter for the Apex method
        action2.setParams({
            recordTypeName: recordTypeName
        });
        
        action2.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.feedbackList", response.getReturnValue());
            } else if (state === "ERROR") {
                component.set("v.error", response.getError());
                component.set("v.feedbackList", []);
            }
        });
        
        $A.enqueueAction(action2);
    }
})