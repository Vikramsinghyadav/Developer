public class MVPNomineeBasicInfo2 {
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldSet(String objectName, String fieldSetName) {
        List<String> fieldList = new List<String>();
        Schema.FieldSet fieldSetObj = Schema.getGlobalDescribe().get(objectName).getDescribe().fieldSets.getMap().get(fieldSetName);
        
        if (fieldSetObj != null) {
            for (Schema.FieldSetMember f : fieldSetObj.getFields()) {
                fieldList.add(f.getFieldPath());
            }
        }
        return fieldList;
    }
    @AuraEnabled(cacheable=true)
    public static String getParent(String recordid) {
        List<Designation__c> desList = [SELECT Contact__c FROM Designation__c WHERE Id = :recordid LIMIT 1];
        Id contactId=desList[0].Contact__c;
        return contactId;
    }
     @AuraEnabled(cacheable=true)
    public static Decimal getContactData( String recordid) {
        Designation__c des=[select id,Contact__c from Designation__c where id = :recordid LIMIT 1];
        Contact con=[select Feedback_Rating_Count__c from Contact where id=:des.contact__c LIMIT 1];
        Decimal rating=con.Feedback_Rating_Count__c;
        return rating;
    }
}