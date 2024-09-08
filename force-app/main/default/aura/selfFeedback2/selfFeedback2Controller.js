({
    doInit: function (component, event, helper) {
       

        // Fetch Feedback records
        var action2 = component.get("c.getRecordFeedback");

// Get the recordTypeName from the component (ensure this attribute is populated in your component)
var recordTypeName = component.get("v.recordTypeName");

// Check if recordTypeName is not null or undefined before proceeding
if (recordTypeName) {
    // Set the parameter for the Apex method
    action2.setParams({
        recordTypeName: recordTypeName
    });

    // Set the callback function to handle the response
    action2.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            // Log the returned feedback data
            var feedbackData = response.getReturnValue();

            // Set the feedbackList attribute with the returned data
            component.set("v.feedbackList", feedbackData);

            // Additional logging for the feedback list
        } else if (state === "ERROR") {
            // Handle the error state
            var errors = response.getError();
            console.error('Error:', errors);

            // Set the error attribute and clear the feedback list
            component.set("v.error", errors);
            component.set("v.feedbackList", []);
        }
    });

    // Enqueue the action to send it to the server
    $A.enqueueAction(action2);
} else {
    // Handle the case where recordTypeName is not set
    console.error('recordTypeName is not set or is invalid.');
    component.set("v.error", 'Record Type Name is not set or is invalid.');
    component.set("v.feedbackList", []);
}

    }
})