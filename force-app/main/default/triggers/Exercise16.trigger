trigger Exercise16 on Task (after insert,after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	TaskController.changeOpportunityStage(Trigger.new);
    }
}