 public class AccountClassifier {
    public List<Account> classifyAccount(List<String> oppIds){
        List<String> accIds = new List<String>();
        for(String id: oppIds){
            List<Opportunity> oppList = [SELECT AccountId FROM Opportunity WHERE Id = :id ];
            if(oppList.size() > 0){
                String accId = oppList[0].AccountId;
                AggregateResult[] groupedResults = [SELECT sum(Amount) total FROM Opportunity WHERE AccountId = :accId];
                Decimal totalAmount = (Decimal) groupedResults[0].get('total');
                if(totalAmount > 500000){
                 	accIds.add(accId);
                }
            }
        }
        System.debug(accIds.size());
        List<Account> accList = new List<Account>();
        for(String accId: accIds){
           Account acc = [SELECT ID, Customer_Priority__c FROM Account WHERE Id=:accId limit 1];
           acc.Customer_Priority__c = 'High';
           accList.add(acc);
        }
        upsert(accList);
        return accList;
    } 
}