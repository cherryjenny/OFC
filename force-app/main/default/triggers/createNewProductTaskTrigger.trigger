trigger createNewProductTaskTrigger on Product2 (after insert, after update) {

    List<Task> tasksToInsert = new List<Task>();

    Set<Id> prodIds = new Set<Id>();
    for (Product2 updatedProduct : Trigger.new) {
        productIds.add(updatedProduct.Id);
    }

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
         List<OpportunityLineItem> opptyProds = [SELECT Opportunity.Accoun1tId FROM OpportunityLineItem WHERE Product2.Family = :familyValue];
         for (OpportunityLineItem opptyProd : opptyProds) {
             accountIds.add(opptyProd.Opportunity.AccountId);
         }
     }

     accounts = [SELECT Id, OwnerId  FROM Account WHERE Id IN :accountIds];
     Date today = Date.today();

     for (Account account : accounts) {
        Task newTask = new Task();
        newTask.Subject = 'Email'; // 작업 제목 설정
        newTask.Description = '기회확보: 신제품 홍보 이메일 전송'; // 작업 설명 설정
        newTask.WhatId = account.Id; // 작업과 연관된 객체 설정 (계정)
        newTask.WhoId = account.OwnerId;
        newTask.ActivityDate = today.addDays(7); // 작업 기한 설정 (오늘)
        newTask.Status = 'Not Started'; // 작업 상태 설정
        tasksToInsert.add(newTask); // 작업을 작업 목록에 추가
    }
    
}