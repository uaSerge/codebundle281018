/**
 * Created by Serhii on 24.10.2018.
 */

public with sharing class MerchController {
//main controller of web shop
    @AuraEnabled
    public static List<Merchandise__c> getMerchandises() {
        String[] fieldsToCheck = new String[]{
                'Id', 'Name', 'Picture__c', 'Category__c', 'Description__c',
                'Price__c', 'Quantity__c'
        };

        Map<String, Schema.SObjectField> fieldDescribeTokens =
                Schema.SObjectType.Merchandise__c.fields.getMap();

        for (String field : fieldsToCheck) {
            if (!fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        return [
                SELECT Id, Name, Picture__c, Category__c, Description__c,
                        Price__c, Quantity__c
                FROM Merchandise__c
        ];
    }

    @AuraEnabled
    public static List<Merchandise__c> getNotes() {
        String categoryString = 'Notebooks';
        return getCategory(categoryString);
    }

    @AuraEnabled
    public static List<Merchandise__c> getMons() {
        String categoryString = 'Monitors';
        return getCategory(categoryString);
    }
    @AuraEnabled
    public static List<Merchandise__c> getKes() {
        String categoryString = 'Keyboards';
        return getCategory(categoryString);
    }
    @AuraEnabled
    public static List<Merchandise__c> getMouses() {
        String categoryString = 'Mouses';
        return getCategory(categoryString);
    }

    public static List<Merchandise__c> getCategory(String categoryString) {
// Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[]{
                'Id', 'Name', 'Picture__c', 'Category__c', 'Description__c',
                'Price__c', 'Quantity__c'
        };
        Map<String, Schema.SObjectField> fieldDescribeTokens =
                Schema.SObjectType.Merchandise__c.fields.getMap();
        for (String field : fieldsToCheck) {
            if (!fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        return [
                SELECT Id, Name, Picture__c, Category__c, Description__c,
                        Price__c, Quantity__c
                FROM Merchandise__c
                WHERE Category__c = :categoryString
        ];
    }
    @AuraEnabled
    public static void createInvoice(List <Merchandise__c> merchandises) {
        if (merchandises.size() > 0) {
            Invoice__c inv = new Invoice__c(Status__c = 'Open');
            insert inv;
            System.debug('Invoice__c id ' + inv.id);
            List <Invoice_Line_Item__c> lineItems = new List<Invoice_Line_Item__c>();
            for (Merchandise__c merch : merchandises) {
                if (merch.Quantity__c > 0 && merch.Quantity__c != null) {
                    Invoice_Line_Item__c item = new Invoice_Line_Item__c(Invoice__c = inv.id,
                            Merchandise__c = merch.id, Quantity__c = merch.Quantity__c, Unit_Price__c = merch.Price__c);
                    lineItems.add(item);
                    System.debug('Invoice_Line_Item__c' + item);
                }
            }
            insert lineItems;
            upsert inv;
        }
    }
}