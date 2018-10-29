/*
 * Created by Serhii on 27.10.2018.
 */
public with sharing class DelinvoiceExt {
//in invoice record detail dell all button
    @AuraEnabled
    public static void delAll() {
        System.debug('delAll');
        List<Invoice__c> invoiceList = [SELECT ID FROM Invoice__c];
        try {
            delete invoiceList;
        } catch (Exception ex)
        {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled
    public static List<Invoice__c> getInvs() {
        String[] fieldsToCheck = new String[]{
                'Id', 'Name', 'Status__c', 'Invoice_Total__c', 'Description__c'
                };

        Map<String, Schema.SObjectField> fieldDescribeTokens =
                Schema.SObjectType.Invoice__c.fields.getMap();

        for (String field : fieldsToCheck) {
            if (!fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        return [
                SELECT Id, Name, Status__c, Invoice_Total__c, Description__c
                FROM Invoice__c
        ];
    }
}