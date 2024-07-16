trigger Exercise7 on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.CannotContainA(Trigger.new);
    }
}