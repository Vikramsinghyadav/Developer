public class LeadController {
    public static void CheckCountryPhoneLength(List<Lead> leadList){
        for(Lead ld:leadList){
            if(ld.country__c=='United States' && ld.Phone != null && ld.Phone.length() != 10){
                    ld.Phone.addError('phone number must have 10 digits ');
            }
            if(ld.Phone==null && ld.Email==null){
                ld.Phone.addError('Either Phone or Email should be populated');
                ld.Email.addError('Either Phone or Email should be populated');
            }
        }
    }
    public static void domainName(List<Lead> leadList){
        for(Lead ld:leadList){
            if(ld.Email!=null){
                String currentemail=ld.Email;
                CheckEmail(currentemail);
            }
        }
        private static void CheckEmail(String currentemail){
            if(currentemail.endsWith('.games')){
                ld.Email.addError('email cannot ends with .games');
            }else if(currentemail.endsWith('.garden')){
                ld.Email.addError('email cannot ends with  .garden'); 
            }else if(currentemail.endsWith('.glass')){
                ld.Email.addError('email cannot ends with .glass');
            }else if(currentemail.endsWith('.free')){
                ld.Email.addError('email cannot ends with .free');
            }else if(currentemail.endsWith('.talk')){
                ld.Email.addError('email cannot ends with .talk');
            }
            if(currentemail.startsWith('info@')){
                ld.Email.addError('email cannot starts with info@');
            }else if(currentemail.startsWith('contact@')){
                ld.Email.addError('email cannot starts with contact');
            }else if(currentemail.startsWith('Career@')){
                ld.Email.addError('email cannot starts with Career@');
            }
        }
    }
    public static void appendZ(List<Lead> leadList, Map<Id,Lead> oldMap){
        for(Lead ld:leadList){
            if(ld.Email!=null && ld.Email.length()<20 && ld.Email!=oldMap.get(ld.Id).Email ){
                    EmailOfCurrentRecord=EmailOfCurrentRecord+'z';
                    ld.Email=EmailOfCurrentRecord;   
            } 
        }
    }
    public static void cannotContainA(List<Lead> leadList,Map<Id,Lead> oldMap){
        for (Lead ld : leadList) {
            if (ld.Email != null && ld.Email!=oldMap.get(ld.Id).Email) {
                String currentemail = ld.Email;
                String emailSubstring=str.substring(5, 12);
               
                if (emailSubstring.contains('a')) {
                    ld.Email.addError('Letter a cannot be there between the 5th and 12th character');
                }
            }
        }
    }
    public static void createCampaignmember(List<Lead> leadList){
        Map<String, Id> sourceToCampaignIdMap = new Map<String, Id>();

    // Query all campaigns and populate the map with their names and IDs
    for (Campaign campaign : [SELECT Id, Name FROM Campaign]) {
        sourceToCampaignIdMap.put(campaign.Name, campaign.Id);
    }

    List<CampaignMember> campaignMembersToInsert = new List<CampaignMember>();

    for (Lead lead : leadList) {
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
    public static void statusUnqualified(List<Lead> leadList) {
        for(Lead ld:leadList){
            if(ld.Status=='Unqualified'){
                if(ld.Reason__c==null){
                    ld.Reason__c.addError('if status is Unqualified this field should be populated');
                }
            }
        }
    }
}