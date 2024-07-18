trigger Exercise17 on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.statusUnqualified(Trigger.new);
    }
}