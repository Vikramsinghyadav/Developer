@isTest
public class Exercise12Test {
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
        System.debug('testOpportunity '+testOpportunity);
        insert testOpportunity;
        
        // Verify that the contract was created
        List<Contract> contracts = [SELECT Id, Name, Status, StartDate, AccountId FROM Contract WHERE AccountId = :testAccount.Id];
        System.assertEquals(1, contracts.size());
        Contract createdContract = contracts[0];
        
        // Validate the contract fields
        System.assertEquals('Draft', createdContract.Status);
        System.assertEquals(System.today(), createdContract.StartDate);
        System.assertEquals(testAccount.Id, createdContract.AccountId);
        //System.assertEquals(testOpportunity.Id, createdContract.OpportunityId);
    }


}