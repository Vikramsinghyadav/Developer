public class OpportunityController {
    public static void populateNextStep(List<Opportunity> oppList,Map<Id,Opportunity> OldMap){
        for(Opportunity op:oppList){
            if(op.StageName=='Closed Won' && OldMap.get(op.id).StageName=='Negotiation/Review' && op.NextStep!=null){
                op.NextStep.addError('Next Step should be empty at this point of time');
            }
                op.NextStep='Next Step should be populated exercise 7 ';
            }
        }
    }
    public static void createContract(List<Opportunity> oppList){
        List<Contract> contractsToInsert = new List<Contract>();
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Opportunity opp : oppList) {
            if (opp.StageName == 'Closed Won') {
                opportunities.add(opp.Id);
            }
        }
        if (!opportunities.isEmpty()) {
            
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
    public static void closeDateCheck(List<Opportunity> oppList){
        for(Opportunity op:oppList){  
            Date lastDayOfCurrentMonth = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
            if(op.CloseDate>lastDayOfCurrentMonth){
                op.CloseDate.addError('Close Date sholud not greater than the last date of the current month.');
            }
        }
    }
}