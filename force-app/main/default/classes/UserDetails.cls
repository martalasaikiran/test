public with sharing class UserDetails {
    @AuraEnabled
    public static Id validateLoginDetails(String username, String password) {
        List<UserDetail__c> users = [
            SELECT Id, username__c, password__c, Email__c
            FROM UserDetail__c
            WHERE Username__c = :username AND Password__c = :password
            LIMIT 1
        ];
 
        if (!users.isEmpty()) {
            UserDetail__c user = users[0];
            List<Login_Activity__c> activities = [
                SELECT Id, LoginTiming__c
                FROM Login_Activity__c
                WHERE Name = :username
                ORDER BY CreatedDate DESC
                LIMIT 1
            ];
 
            Login_Activity__c activity;
            if (!activities.isEmpty()) {
                activity = activities[0];
                activity.LoginTiming__c = System.now();
                activity.LogoutTiming__c=null;
                update activity;
            } else {
                    activity = new Login_Activity__c(
                    Name = username,
                    User__c = user.Id,
                    LoginTiming__c = System.now()
                );
                insert activity;
            }
 
            // Send login email
            sendEmail(user.Email__c, 'martalasaikiranreddy1119@gmail.com',
                'Login Notification',
                'User ' + username + ' logged in at ' + System.now().format());
 
            return activity.Id;
        }
 
        return null;
    }
 
    @AuraEnabled
    public static void handleLogout(Id loginActivityId) {
        Login_Activity__c activity = [
            SELECT Id, LoginTiming__c
            FROM Login_Activity__c
            WHERE Id = :loginActivityId
            LIMIT 1
        ];
 
        activity.LogoutTiming__c = System.now();
        update activity;
 
        Long timeSpent = activity.LogoutTiming__c.getTime() - activity.LoginTiming__c.getTime();
        String duration = String.valueOf((Integer)(timeSpent / 60000)) + ' minutes';
 
        sendEmail('admin@example.com', 'martalasaikiranreddy1119@gmail.com',
            'Logout Notification',
            'User logged out at ' + System.now().format() +
            '\nLogin Time: ' + activity.LoginTiming__c.format() +
            '\nTime spent: ' + duration);
    }
 
    private static void sendEmail(String to1, String to2, String subject, String body) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { to1, to2 });
        mail.setSubject(subject);
        mail.setPlainTextBody(body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
    @AuraEnabled(cacheable=true)
    public static List<Login_Activity__c> getRecentLogins() {
        DateTime cutoff = System.now().addHours(-24);
        return [
            SELECT Id, Name, LoginTiming__c, LogoutTiming__c, User__c
            FROM Login_Activity__c
            WHERE LoginTiming__c >= :cutoff
        ];
    }
    @AuraEnabled(cacheable=true)
    public static Boolean managerAuthenticated(Id loginActivityId) {
        Login_Activity__c loginActivity = [
            SELECT Id, User__r.Manager__c
            FROM Login_Activity__c
            WHERE Id = :loginActivityId
            LIMIT 1
        ];
        System.debug('loginActivity.User__r.Manager__c--?>'+loginActivity.User__r.Manager__c);
        //console.log('loginActivity.User__r.Manager__c'+loginActivity.User__r.Manager__c);
        return loginActivity.User__r.Manager__c ;
    }
    @AuraEnabled(cacheable=true)
    public static Integer getActiveUserCount() {
        DateTime cutoff = System.now().addHours(-1); // last 1 hour (adjust if needed)
        return [SELECT COUNT() FROM Login_Activity__c WHERE LogoutTiming__c = : NULL AND LoginTiming__c >= :cutoff];
    }
 
   
 
}