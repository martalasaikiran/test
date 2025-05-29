public with sharing class LoginNotificationController {
    @AuraEnabled
    public static void sendEmail(String username, String loginTime, String type, String logoutTime, String timeSpent) {
        // Replace with logic to fetch actual manager and admin emails
        String managerEmail = 'manager@example.com';
        String adminEmail = 'admin@example.com';

    
        String subject = type == 'login' ? 'User Login Notification' : 'User Logout Notification';
        String body = 'Username: ' + username + '\n' +
                      'Login Time: ' + loginTime + '\n';
        if (type == 'logout') {
            body += 'Logout Time: ' + logoutTime + '\n' +
                    'Time Spent: ' + timeSpent + '\n';
        }

        // Create email message
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] { managerEmail, adminEmail });
        email.setSubject(subject);
        email.setPlainTextBody(body);

        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }
}