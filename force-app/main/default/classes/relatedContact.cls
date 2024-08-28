public class relatedContact {
	 @AuraEnabled(Cacheable=true)
    public static List<Contact> getContacts(Id acid) {
        List<Contact> acclist=[select AccountId,FirstName,LastName,Phone from Contact where AccountId=:acid with SECURITY_ENFORCED];
	    System.debug('acclist->'+acclist);
        return acclist;
    }
   @AuraEnabled
    public static void deleteRecords(Id conid) {
        System.debug('delete yes'+conid);
        
        // Collect records to be deleted
        List<Contact> lisToDelete = [SELECT AccountId, FirstName, LastName, Phone FROM Contact WHERE Id = :conid WITH SECURITY_ENFORCED];
        
        try {
            System.debug(lisToDelete);
            
            if (!lisToDelete.isEmpty()) {
                // Perform bulk delete outside the loop
                delete lisToDelete;
            }
            
            System.debug(lisToDelete);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }	
    }
	@AuraEnabled
    public static void saveRecords(List<Contact> listToSave) {
        System.debug('save');
        try{
            
            for(Contact c:listToSave){
                System.debug('acclid '+c.AccountId+' name->'+c.FirstName);
            }
            System.debug('newconlist'+listToSave);
          
            if(!listToSave.isEmpty()){
                upsert listToSave;
            }
        }catch(Exception e){
            System.debug('error in save 1: '+e.getMessage());
            //throw new AuraHandledException('error saving 2'+e.getMessage());
        }
    }
}