trigger OpportunityChangeAsyncTrigger on OpportunityChangeEvent (after insert) {
    List<OpportunityChangeEvent> changes = Trigger.new;
    
    Set<String> oppIds = new Set<String>();
    
    //Get all record Ids for this change and add it to a set for further processing
    for(OpportunityChangeEvent opp: changes){
        List<String> recordIds = opp.ChangeEventHeader.getRecordIds();
        oppIds.addAll(recordIds);
    }
    
    System.debug(oppIds.size());
    //Perform heavy computation operation which may take a lot of time
    AccountClassifier classifier = new AccountClassifier();
    List<Account> highPriorityAccounts = classifier.classifyAccount(new List<String>(oppIds));
    System.debug(highPriorityAccounts);
    

    
    //Perform any additional activity after heavy computation. 
    //You may publish platform events for possible high priority Accounts.
}