trigger Exercise4 on Lead (before insert,after insert, after update) {
    Map<String, Id> sourceToCampaignIdMap = new Map<String, Id>();

    // Query all campaigns and populate the map with their names and IDs
    for (Campaign campaign : [SELECT Id, Name FROM Campaign]) {
        sourceToCampaignIdMap.put(campaign.Name, campaign.Id);
    }

    List<CampaignMember> campaignMembersToInsert = new List<CampaignMember>();

    for (Lead lead : Trigger.new) {
        if (lead.LeadSource != null && sourceToCampaignIdMap.containsKey(lead.LeadSource)) {
            CampaignMember campaignMember = new CampaignMember(
                LeadId = lead.Id,
                CampaignId = sourceToCampaignIdMap.get(lead.LeadSource)
            );
            campaignMembersToInsert.add(campaignMember);
        }
    }

    if (!campaignMembersToInsert.isEmpty()) {
        insert campaignMembersToInsert;
    }


}