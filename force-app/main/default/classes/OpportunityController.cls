public class OpportunityController {
    public static void PopulateNextStep(List<Opportunity> oppList,Map<Id,Opportunity> OldMap){
        for(Opportunity op:oppList){
            if(op.StageName=='Closed Won' && OldMap.get(op.id).StageName=='Negotiation/Review'){
                op.NextStep='Next Step should be populated exercise 7 ';
            }
        }
    }
    public static void CreateContract(List<Opportunity> oppList){
        List<Contract> contractsToInsert = new List<Contract>();
        Set<Id> opportunityIds = new Set<Id>();
        for (Opportunity opp : oppList) {
            if (opp.StageName == 'Closed Won') {
                opportunityIds.add(opp.Id);
            }
        }
        if (!opportunityIds.isEmpty()) {
            List<Opportunity> opportunities = [SELECT Id,Name, AccountId, CloseDate FROM Opportunity WHERE Id IN :opportunityIds];
            
            for (Opportunity opp : opportunities) {
                Contract con = new Contract();
                con.Name = opp.Name + ' Contract';
                con.Status = 'Draft';
                con.StartDate = System.today();
                con.ContractTerm = 12; // 12 months equals 1 year
                con.AccountId = opp.AccountId;
                contractsToInsert.add(con);
            }
            if (!contractsToInsert.isEmpty()) {
                insert contractsToInsert;
            }
        }        
    }
    public static void CloseDateCheck(List<Opportunity> oppList){
        for(Opportunity op:oppList){  
            Date lastDayOfCurrentMonth = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
            System.debug('lastDayOfCurrentMonth '+lastDayOfCurrentMonth);
            if(op.CloseDate>lastDayOfCurrentMonth){
                op.CloseDate.addError('Close Date sholud not greater than the last date of the current month.');
            }
        }
    }
}