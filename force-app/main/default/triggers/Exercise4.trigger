trigger Exercise4 on Lead (before insert,after insert, after update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.createCampaignmember(Trigger.new);
    }
}