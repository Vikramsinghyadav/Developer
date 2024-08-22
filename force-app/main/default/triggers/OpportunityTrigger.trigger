trigger OpportunityTrigger on Opportunity (before insert,before update,after insert, after update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	OpportunityController.populateNextStep(Trigger.new,Trigger.oldMap);
        OpportunityController.closeDateCheck(Trigger.new);
    }
     if(Trigger.isAfter && ( Trigger.isUpdate)){
    	OpportunityController.createContract(Trigger.new);
    }
}