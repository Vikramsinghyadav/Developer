public class AccountTriggerHandler {
    public static void startsWith5(List<Account> accList){
        for(Account acc:accList){
            
            if(acc.BillingPostalCode.startsWith('5')){
                acc.Industry='Biotechnology';
            }
        }
    }
    public static void startsWith7(List<Account> accList){
        Set<Id> AccountIds=new Set<Id>();
        for(Account acc:accList){
            if(acc.BillingPostalCode.startsWith('7')){
                AccountIds.add(acc.id);
            }
        }
        List<Opportunity> oppList=new List<Opportunity>(); 
        if(!AccountIds.isEmpty()){
            for(Opportunity op:[select id,StageName,CloseDate,Name from Opportunity where AccountId IN :AccountIds]){
                op.StageName='Closed Won';
                oppList.add(op);
            }
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
}