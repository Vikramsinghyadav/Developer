@isTest
public class Exercise13Test {
    @isTest
    static void testOpportunityCloseDateWithinCurrentMonth() {
        // Get the last day of the current month
        Date lastDayOfCurrentMonth = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
        
        // Create a new opportunity with a Close Date within the current month
        Opportunity opp = new Opportunity(
            Name = 'Test Opportunity Within Current Month',
            CloseDate = lastDayOfCurrentMonth,
            StageName = 'Prospecting'
        );
        
        Test.startTest();
        insert opp;
        Test.stopTest();
        
        // Verify that the opportunity is inserted without errors
        Opportunity insertedOpp = [SELECT Id, CloseDate FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals(lastDayOfCurrentMonth, insertedOpp.CloseDate);
    }
    
    @isTest
    static void testOpportunityCloseDateBeyondCurrentMonth() {
        // Get the last day of the current month
        Date lastDayOfCurrentMonth = Date.today().toStartOfMonth().addMonths(1).addDays(-1);
        
        // Create a new opportunity with a Close Date beyond the current month
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
            // Verify that the DML exception is due to the Close Date validation
            System.assert(e.getMessage().contains('Close Date cannot be greater than the last date of the current month.'));
        }
        Test.stopTest();
    }


}