trigger Exercise13 on Opportunity (before insert) {//correction
     if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        OpportunityController.CloseDateCheck(Trigger.new);
    }
}