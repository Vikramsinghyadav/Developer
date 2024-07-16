trigger Exercise7Opportunity on Opportunity (before update) {
    if(Trigger.isBefore && Trigger.isUpdate){
    	OpportunityController.PopulateNextStep(Trigger.new,Trigger.oldMap);
    }
}