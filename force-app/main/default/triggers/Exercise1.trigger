trigger Exercise1 on Lead (before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.Country(Trigger.new);
    }
}