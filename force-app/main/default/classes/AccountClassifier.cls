 public with sharing class AccountClassifier {
    public List<Account> classifyAccount(List<String> oppIds){
        List<String> accIds = new List<String>();
        List<Account> highPriorityAccounts;
        
        // get the account ids from the list of opportunities
        List<Opportunity> oppList = [SELECT AccountId FROM Opportunity WHERE Id IN :oppIds ];
        System.debug('Hello');

        if (null != oppList && oppList.size() > 0) {
            for (Opportunity o : oppList) {
                accIds.add(o.AccountId);
            }
            //Process all the accounts to check and set the priority
            highPriorityAccounts = processPriority(accIds);
            return highPriorityAccounts;
        } else {
            return new List<Account>();
        }
    } 

    //process all the accounts to very the criteria and set it as High priority account
    List<Account> processPriority(List<String> accIds){
        List<String> highPriorityAccIds = new List<String>();
        List<Opportunity> oppForAccounts = [SELECT Id,AccountId,Amount From Opportunity WHERE AccountId IN :accIds AND StageName!='Closed Won'];  
        Map<String, List<Opportunity>> accsToOpps = new Map<String, List<Opportunity>>();
        
        //Identify and map all the opportunities for a given account
        for (Opportunity o : oppForAccounts) {
            if (null == o.AccountId) continue;
            if (!accsToOpps.containsKey(o.AccountId)) {
                accsToOpps.put(o.AccountId, new List<Opportunity>());
            }
            accsToOpps.get(o.AccountId).add(o);
        }

        Decimal totalAmount = 0;
        //Check the total value of all the opportunities for each account
        for (String acctId : accsToOpps.keySet()) {
            for(Opportunity opp: accsToOpps.get(acctId)){
                totalAmount += opp.Amount;
            }
            System.debug('total amount: ' + totalAmount);
            if(totalAmount > 500000){
                highPriorityAccIds.add(acctId);
            }
        }
        List<Account> highPriorityAccounts = [SELECT ID, Name, Customer_Priority__c FROM Account WHERE Id IN :highPriorityAccIds];

        //Once the criteria is satisfied, set the accounts as high priority accounts
        for(Account acc : highPriorityAccounts){
            acc.Customer_Priority__c = 'High';
        }

        update(highPriorityAccounts);
        return highPriorityAccounts;
    }
}