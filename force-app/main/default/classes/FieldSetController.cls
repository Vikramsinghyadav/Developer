public with sharing class FieldSetController {
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldSetFields(String objectName, String fieldSetName) {
        if (String.isEmpty(fieldSetName)) {
            return null;
        }
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
    public static Decimal getContactData( String recordid) {
        Designation__c des=[select id,Contact__c from Designation__c where id = :recordid LIMIT 1];
        Contact con=[select Feedback_Rating_Count__c from Contact where id=:des.contact__c LIMIT 1];
        Decimal rating=con.Feedback_Rating_Count__c;
        return rating;
    }
    
}