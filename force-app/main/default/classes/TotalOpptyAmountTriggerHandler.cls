public class TotalOpptyAmountTriggerHandler {
    public static void handleTrigger(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunitiesMap,
                                     Boolean isInsert, Boolean isUpdate, Boolean isDelete, Boolean isUndelete) {
        if (isInsert || isUpdate || isUndelete) {
            updateAccountTotalOpportunityAmount(newOpportunities);
        } else if (isDelete) {
            updateAccountTotalOpportunityAmount(getClosedWonOpportunities(oldOpportunitiesMap.values()));
        }
    }

    private static List<Opportunity> getClosedWonOpportunities(List<Opportunity> opportunities) {
        List<Opportunity> closedWonOpportunities = new List<Opportunity>();
        for (Opportunity opportunity : opportunities) {
            if (opportunity.StageName == '성공') {
                closedWonOpportunities.add(opportunity);
            }
        }
        return closedWonOpportunities;
    }

    private static void updateAccountTotalOpportunityAmount(List<Opportunity> opportunities) {
        //trigger된 oppty의 account 조회
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opportunity : opportunities) {
            accountIds.add(opportunity.AccountId);
        }

        //account의 모든 oppty중에 Closed Won인 애들만 조회
        List<Account> accountsToUpdate = [SELECT Id,
                                          (SELECT Amount, StageName FROM Opportunities WHERE StageName = '성공')
                                          FROM Account WHERE Id IN :accountIds];
            //oppty의 amount들 총합 구하기
             for (Account account : accountsToUpdate) {
            Decimal totalAmount = 0;
            for (Opportunity opportunity : account.Opportunities) {
                if (opportunity.StageName == '성공') {
                    totalAmount += opportunity.Amount;
                }
            }
            //totalOpptyaccount 필드 업데이트 하기
            account.TotalOpportunityAmount__c = totalAmount;
        }
        //account들 업데이트
        update accountsToUpdate;
    }
}