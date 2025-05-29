public class userRecordCreation{
@AuraEnabled(cacheable=false)
public static void createUser(String username, String email, String password, String roleName) {
    system.debug('usename is '+username);
    system.debug('email is '+email);
    system.debug('password is '+password);
    try {
    // user giving the role name from ui i want get that role id from role hirarch and by using it iam assigning to the user to that role after creating the user record in user object 

        UserRole userRole = [SELECT Id FROM UserRole WHERE Name = :roleName LIMIT 1];
        //Here Iam Taking the static profile 
        Profile profile = [SELECT Id FROM Profile WHERE Name = 'Chatter Free User' LIMIT 1];

        User newUser = new User();
        newUser.Email = email;

        //newUser.Username = email; making error as duplicate user in another org 
        newUser.Username = email.replace('@', '.' + DateTime.now().getTime() + '@');
        newUser.LastName = 'Default'; 
        newUser.Alias = username.length() >= 8 ? username.substring(0, 8) : username;
        newUser.CommunityNickname = username;
        newUser.TimeZoneSidKey = 'Asia/Kolkata';
        newUser.LocaleSidKey = 'en_IN';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.ProfileId = profile.Id;
        newUser.UserRoleId = userRole.Id;
        newUser.IsActive = true;

        insert newUser;

        System.setPassword(newUser.Id, password);

    } catch (Exception e) {
        System.debug('Error while creating user: ' + e.getMessage()+'at line number'+e.getLineNumber());
        
    }
  }
}