@isTest
public class TotalOpptyAmountTrigger_Test {
    @testSetup
    static void setupTestData() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account', Businesscode__c= '524-25-11582');
        insert testAccount;

        // Create Opportunities
        List<Opportunity> testOpportunities = new List<Opportunity>();
        testOpportunities.add(new Opportunity(Name = 'Opportunity 1', StageName = '성공',
                                             Amount = 2000, AccountId = testAccount.Id, 
                                             CloseDate = Date.today().addDays(10)));
        testOpportunities.add(new Opportunity(Name = 'Opportunity 2', StageName = '실패',
                                             Amount = 1000, AccountId = testAccount.Id,
                                             CloseDate = Date.today().addDays(5)));

        insert testOpportunities;
    }

    @isTest
    public static void testTotalOpptyAmountTrigger() {
        // 만든 Account 가져오기
        Account testAccount = [SELECT Id, TotalOpportunityAmount__c FROM Account LIMIT 1];
        // Account의 totalamount 조회, 이전에 넣은 2000이 맞는지 확인
        System.assertEquals(2000, testAccount.TotalOpportunityAmount__c);
        Opportunity testOpportunity = [SELECT Id, StageName, Amount FROM Opportunity WHERE StageName = '성공' LIMIT 1];

        // 1500으로 insert
        Opportunity newOpportunity = new Opportunity(Name = 'New Opportunity', StageName = '성공',
                                                    Amount = 1500, AccountId = testAccount.Id,
                                                    CloseDate = Date.today().addDays(15));
        insert newOpportunity;

        //totalamount 다시 조회, 이번엔 2000 + 1500이어야 함.
        testAccount = [SELECT Id, TotalOpportunityAmount__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(3500, testAccount.TotalOpportunityAmount__c);

        // 새로운 oppty update
        testOpportunity.StageName = '실패';
        update testOpportunity;

        // 이번엔 2000-1500이어야 함.
        testAccount = [SELECT Id, TotalOpportunityAmount__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(1500, testAccount.TotalOpportunityAmount__c);

        // 다시 won으로 update
        testOpportunity.StageName = '성공';
        update testOpportunity;

        // 2000 + 1500
        testAccount = [SELECT Id, TotalOpportunityAmount__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(3500, testAccount.TotalOpportunityAmount__c);

        // delete
        delete testOpportunity;

        testAccount = [SELECT Id, TotalOpportunityAmount__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(1500, testAccount.TotalOpportunityAmount__c);
        
        // Undelete
        undelete testOpportunity;
        
        testAccount = [SELECT Id, TotalOpportunityAmount__c FROM Account WHERE Id = :testAccount.Id];
        System.assertEquals(3500, testAccount.TotalOpportunityAmount__c);
    }
}