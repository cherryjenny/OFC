public with sharing class ProductController {
  @AuraEnabled(cacheable=true)
  public static List<Product2> getProducts() {
    return [
      SELECT
        Id,
        Name,
        Description,
        Family,
        Standard_Price__c,
        Unit_of_Packed__c,
        IMG_Document_Generation__c
      FROM Product2
      LIMIT 15
    ];
  }
}