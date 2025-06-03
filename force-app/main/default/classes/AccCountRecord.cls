public class AccCountRecord {
    public static void countRecord(List<Contact> newList,Map<Id,Contact>oldMap){
        /*
          Set<Id> accountIds=new Set<id>();
        if (newList !=Null){
            for (Contact c:newList){
            if (c.AccountId!=Null){
                accountIds.add(c.AccountId);//account id is adding to the set collection by getting Trigger.New for IsInsert Or Undelete  add to the set collection in hashmap sorting order  
            }
        }
        }
<<<<<<< HEAD
        System.debug('Comment 1');
        System.debug('comment 2');
        
=======
        System.debug('Comment ');
>>>>>>> main
        if (oldMap != null) {
            for (Contact c : oldMap.values()) {
                if (c.AccountId != null) {
                    accountIds.add(c.AccountId);// By getting IsUpdate or IsDelete  accountid add to the Set colletion in hashmap Sorting Order 
                }
            }
        }
        Map<Id, Integer> contactCounts = new Map<Id, Integer>();
        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) contactCount
            FROM Contact
            WHERE AccountId IN :accountIds  // check in the select collection by using IN Operator 
            GROUP BY AccountId
        ]) {
              Id accountId = (Id) ar.get('AccountId');
    Integer contactCount = (Integer) ar.get('contactCount');
        contactCounts.put(accountId, contactCount);
	 
	 

        }
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountIds) {
            Account acc = new Account(
                Id = accId,
                Contact_Count__c = contactCounts.containsKey(accId) ? contactCounts.get(accId) : 0 //If yes update ar else 0 
            );
            accountsToUpdate.add(acc);
        }
 
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
            */
    }
 
}