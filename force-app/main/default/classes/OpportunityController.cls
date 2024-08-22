public class OpportunityTriggerHandler {
    public static void populateNextStep(List<Opportunity> oppList, Map<Id, Opportunity> oldMap) {
        for (Opportunity op : oppList) {
            // Check if the Stage is being changed from 'Negotiation/Review' to 'Closed Won'
            if (op.StageName.equals('Closed Won') && oldMap.get(op.Id).StageName.equals('Negotiation/Review')) {
                // Check if the 'NextStep' field is empty
                if (String.isBlank(op.NextStep)) {
                    op.NextStep.addError('The Next Step field must be populated when moving from Negotiation/Review to Closed Won.');
                } else {
                    op.NextStep = 'Next Step should be populated exercise 7';
                }
            }
        }
    }
    
    public static void createContract(List<Opportunity> oppList){
        List<Contract> contractsToInsert = new List<Contract>();
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Opportunity opp : oppList) {
            if (opp.StageName == 'Closed Won') {
                opportunities.add(opp);
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