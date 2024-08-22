public class UserTriggerHandler {
    public static void addIntoQueue (List<User> userList){
        // Query the profile ID for 'Inside Sales'
        Profile insideSalesProfile = [SELECT Id FROM Profile WHERE Name = 'Inside Sales' LIMIT 1];
        // Query the queue ID for 'Marketing Hot Leads'
        Group marketingHotLeadsQueue = [SELECT Id FROM Group WHERE Name = 'Marketing Hot Leads' AND Type = 'Queue' LIMIT 1];
        List<GroupMember> groupMembersToInsert = new List<GroupMember>();
        for (User user : userList) {
            if (user.ProfileId == insideSalesProfile.Id) {
                GroupMember gm = new GroupMember();
                gm.GroupId = marketingHotLeadsQueue.Id;
                gm.UserOrGroupId = user.Id;
                groupMembersToInsert.add(gm);
            }
        }
        if (!groupMembersToInsert.isEmpty()) {
            insert groupMembersToInsert;
        }
    }
}