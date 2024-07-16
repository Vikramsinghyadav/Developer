trigger Exercise12 on Opportunity (after insert, after update) {
     if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	OpportunityController.CreateContract(Trigger.new);
    }
}