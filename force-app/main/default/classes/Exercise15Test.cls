@isTest
public class Exercise15Test {

    @isTest
    static void testUserProfileTrigger() {
        Profile insideSalesProfile = [SELECT Id FROM Profile WHERE Name = 'Inside Sales' LIMIT 1];
        
        Group marketingHotLeadsQueue = [SELECT Id FROM Group WHERE DeveloperName = 'Marketing_Hot_Leads' AND Type = 'Queue' LIMIT 1];
        
        // Create a new user with the 'Inside Sales' profile
        User newUser = new User(
            Username = 'test.insidesales@example.com',
            FirstName = 'Test',
            LastName = 'InsideSales',
            Email = 'test.insidesales@example.com',
            Alias = 'tinsales',
            ProfileId = insideSalesProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        
        Test.startTest();
        insert newUser;
        Test.stopTest();
        
        // Verify that the user is added to the 'Marketing Hot Leads' queue
        GroupMember gm = [SELECT Id FROM GroupMember WHERE GroupId = :marketingHotLeadsQueue.Id AND UserOrGroupId = :newUser.Id];
        System.assertNotEquals(null, gm, 'The new user should be added to the Marketing Hot Leads queue.');
    }
}