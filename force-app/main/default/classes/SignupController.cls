public with sharing class SignupController {
    @AuraEnabled
    public static void createUser(String name, String username, String password, String email, String role, Integer age, Date birthday, Date joiningDate,Boolean isManager) {
        UserDetail__c newUser = new UserDetail__c();
        newUser.Name = name;
        newUser.Username__c = username;
        newUser.Password__c = password;
        newUser.Email__c = email;
        newUser.Role__c = role;
        newUser.Age__c = age;
        newUser.Birthday__c = birthday;
        newUser.Joining_Date__c = joiningDate;
        newUser.Manager__c=isManager;
 
        insert newUser;
    }
}