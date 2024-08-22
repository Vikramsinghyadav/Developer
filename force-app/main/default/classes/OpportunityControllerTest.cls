@isTest
public class OpportunityControllerTest {
    @isTest static void testOpportunityTrigger() {
        // Create test account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create test opportunity
        Opportunity testOpportunity = new Opportunity(
            Name = 'Test Opportunity',
            AccountId = testAccount.Id,
            StageName = 'Closed Won',
            CloseDate = System.today()
        );
        insert testOpportunity;
        
        // Verify that the contract was created
        List<Contract> contracts = [SELECT Id, Name, Status, StartDate, AccountId FROM Contract WHERE AccountId = :testAccount.Id];
        System.assertEquals(1, contracts.size());
        Contract createdContract = contracts[0];      
        // Validate the contract fields
        System.assertEquals('Draft', createdContract.Status);
        System.assertEquals(System.today(), createdContract.StartDate);
        System.assertEquals(testAccount.Id, createdContract.AccountId);
    }
    @isTest
    static void testOpportunityCloseDateWithinCurrentMonth() {
        Date lastDayOfCurrentMonth = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
        
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity Within Current Month',
            CloseDate = lastDayOfCurrentMonth,
            StageName = 'Prospecting'
        );
        
        Test.startTest();
        insert opp;
        Test.stopTest();
        
        Opportunity insertedOpp = [SELECT Id, CloseDate FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(lastDayOfCurrentMonth, insertedOpp.CloseDate);
    }
    
    @isTest
    static void testOpportunityCloseDateBeyondCurrentMonth() {
        Date lastDayOfCurrentMonth = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
        
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity Beyond Current Month',
            CloseDate = lastDayOfCurrentMonth.addDays(1),
            StageName = 'Prospecting'
        );  
        Test.startTest();
        try {
            insert opp;
            System.assert(false, 'Opportunity should not be inserted with a Close Date beyond the current month.');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Close Date cannot be greater than the last date of the current month.'));
        }
        Test.stopTest();
    }
}