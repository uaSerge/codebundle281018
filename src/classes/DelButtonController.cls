/*
 * Created by Serhii on 28.10.2018.
 */
public with sharing class DelButtonController {
    // invoices list dell button
    private ApexPages.StandardSetController ssc;
    private List<Invoice__c> invoiceList;

    public DelButtonController(ApexPages.StandardSetController standardSetController)
        {
            ssc = standardSetController;
            invoiceList = ssc.getRecords();
        }

    public PageReference delAll() {
        String url = 'https://codebundle3-dev-ed.lightning.force.com/lightning/o/Invoice__c/list?filterName=All';
        System.debug('delAll');
        if (Schema.sObjectType.Invoice__c.isDeletable()) {
            try {
                delete invoiceList;
            } catch (Exception ex)
            {
                throw new AuraHandledException(ex.getMessage());
            }
        }
        return new PageReference(url);
    }
}