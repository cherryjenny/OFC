public with sharing class newProductViewController {
    
    @AuraEnabled(Cacheable=true)
    public static List<Product2> getNewProducts(){
        List<Product2> prod = new List<Product2>();
        try {
            prod = [
                SELECT Id, Name, Description, Family
                FROM Product2
                WHERE New_Product__c = TRUE
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Unable to retrieve NewProduct records ' + e.getMessage());
        }
        return prod;
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getFilteredAccounts(List<Id> prodIds) {
        List<Account> accounts = new List<Account>();
        
        try {
            // 현재 사용자의 Id를 가져옵니다.
            //Id userId = UserInfo.getUserId();

            //신제품의 family를 확인
            Set<String> familyValues = new Set<String>();
            for(Id prodId : prodIds){
                for (Product2 prod : [SELECT Id, Name, Family
                                    FROM Product2
                                    WHERE Id = :prodId]) {
                    familyValues.add(prod.Family);
                }
            }

            // family 값들을 이용하여 해당 Opportunity의 AccountId를 조회
            Set<Id> accountIds = new Set<Id>();
            for (String familyValue : familyValues) {
                List<OpportunityLineItem> opptyProds = [SELECT Opportunity.AccountId FROM OpportunityLineItem WHERE Product2.Family = :familyValue];
                for (OpportunityLineItem opptyProd : opptyProds) {
                    accountIds.add(opptyProd.Opportunity.AccountId);
                }
            }

            accounts = [SELECT Id, Name, Phone FROM Account WHERE Id IN :accountIds];

        } catch (Exception e) {
            throw new AuraHandledException('Unable to retrieve account records ' + e.getMessage());
        }

        return accounts;
    }

    // public static List<String> getPicklistOptions() {
    //     List<String> options = new List<String>();
    //     Schema.DescribeFieldResult fieldResult = Product2.Family.getDescribe();
    //     List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();
        
    //     for(Schema.PicklistEntry entry : picklistValues) {
    //         options.add(entry.getLabel());
    //     }
        
    //     return options;
    // }

}