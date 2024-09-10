public class mVPNomineeContributions2 {
@AuraEnabled(cacheable=true)
public static Id getParent(Id recordid) {
    // Query to fetch the Contact__c field from Designation__c object based on the given record Id
    List<Designation__c> desList = [SELECT Contact__c FROM Designation__c WHERE Id = :recordid LIMIT 1];
    
    // Initialize contactId to null
    Id contactId = null;
    
    // Check if the desList is not empty
    if (!desList.isEmpty()) {
        contactId = desList[0].Contact__c;
    }
    
    return contactId;
}

      @AuraEnabled(cacheable=true)
    public static List<MyWrapperClass> getContribution(Id recordid){

        Map<Integer,List<Contribution__c>> conMapWithYear = new Map<Integer,List<Contribution__c>>();

        List<Contribution__c> conList = [SELECT id,name,Date__c FROM Contribution__c WHERE Contact__c = :recordid ];

        List<String> conIds=new List<String>();

        for(Contribution__c con:conList){
            Integer yearValue = con.Date__c.year();

            if(conMapWithYear.containsKey(yearValue)){
                List<Contribution__c> conList2 = conMapWithYear.get(yearValue);
                conList2.add(con);
                conMapWithYear.put(yearValue,conList2);
                
            }else{
                List<Contribution__c> conList2 = new List<Contribution__c>();
                conList2.add(con);
                conMapWithYear.put(yearValue,conList2);
            }
        }
        List<MyWrapperClass> wrapperList = new List<MyWrapperClass>();

        for(Integer i:conMapWithYear.keySet()){
            MyWrapperClass obj = new MyWrapperClass();
            obj.year = ''+i+'('+conMapWithYear.get(i).size()+')';
            obj.contributions = conMapWithYear.get(i);
            wrapperList.add(obj);
        }
        return wrapperList;
    }
     class MyWrapperClass {
        @auraEnabled
        public String year { get; set; }
        @auraEnabled
        public List<Contribution__c> Contributions { get; set; }
    }
@AuraEnabled(cacheable=true)
public static List<String> getFieldSetFields(String objectName, String fieldSetName) {
    
    List<String> fieldList = new List<String>();
    Schema.FieldSet fieldSetObj = Schema.getGlobalDescribe().get(objectName).getDescribe().fieldSets.getMap().get(fieldSetName);
    
    if (fieldSetObj != null) {
        for (Schema.FieldSetMember f : fieldSetObj.getFields()) {
            fieldList.add(f.getFieldPath());
        }
    }
    return fieldList;
}


}