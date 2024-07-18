trigger Exercise4 on Lead (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
    	LeadController.createCampaignmember(Trigger.new);
    }
}