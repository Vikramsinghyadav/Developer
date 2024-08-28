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
     
})