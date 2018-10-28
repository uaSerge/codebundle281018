/**
 * Created by Serhii on 08.10.2018.
 */

public class ActivityDataHandler {
    public static void onAfterInsertDelUndel(List<Account> newAccounts) {
        System.debug(newAccounts);
        Set <Id> terID = new Set <Id> ();
        for (Account a : newAccounts) {
            terID.add(a.Territory__c);
            System.debug('a.Territory__c = ' + a.Territory__c);
        }
        Set <Territory__c> territory = getTerr(terID);
        System.debug('list = ' + territory);
        terrCountNew(territory);
    }

    public static void onAfterUpdate(List<Account> newAccounts, Map<Id, Account> oldMapAccountsByIds) {
        System.debug(newAccounts);
        Set <Id> terID = new Set <Id> ();
        for (Account a : newAccounts) {
            if (oldMapAccountsByIds.containsKey(a.Id)) {
                if (oldMapAccountsByIds.get(a.Id).NumberOfEmployees != a.NumberOfEmployees || oldMapAccountsByIds.get(a.Id).Territory__c != a.Territory__c) {
                    terID.add(a.Territory__c);
                    terID.add(oldMapAccountsByIds.get(a.Id).Territory__c);
                }
            }
            if (!oldMapAccountsByIds.containsKey(a.Id)) {
                terID.add(a.Territory__c);
            }
            System.debug('a.Territory__c = ' + a.Territory__c);
        }
        Set <Territory__c> territory = getTerr(terID);
        System.debug('list = ' + territory);
        terrCountNew(territory);
    }
    
    public static Set <Territory__c> getTerr(Set <ID> terID) {
        return new Set <Territory__c> ([
                SELECT NumberOfEmployees__c,TerritoryModel__r.Id, (
                        SELECT id, NumberOfEmployees, Territory__c
                        from accounts__r
                )
                from Territory__c
                where id in :terID
        ]);
    }

    public static void terrCountNew(Set <Territory__c> territory) {
        System.debug(territory);
        Set <Id> terModIds = new Set <ID> ();

        List <AggregateResult> aggregateResults = [
                select sum(numberOfEmployees) total,Territory__c
                from account
                where Territory__r.id = :territory
                group by Territory__c
        ];
        Map <ID, Territory__c> territoryMap = new Map <ID, Territory__c>(new List <Territory__c> (territory));
        for (AggregateResult aggRes : aggregateResults) {
            System.debug(aggRes);
            territoryMap.get((Id) aggRes.get('Territory__c')).numberOfEmployees__c = (Decimal) aggRes.get('total');
            System.debug('territory.numberOfEmployees__c = ' + (Decimal) aggRes.get('total'));
            if (territoryMap.get((Id) aggRes.get('Territory__c')).TerritoryModel__r != null) {
                terModIds.add(territoryMap.get((Id) aggRes.get('Territory__c')).TerritoryModel__c);
            }
        }
        upsert territoryMap.values();

        if (terModIds.size() > 0) {
            Set <TerritoryModel__c> tModel = new Set <TerritoryModel__c> ([SELECT numberOfEmployees__c from TerritoryModel__c where id in :terModIds]);
            terrModCountNew(tModel);
        }
    }

    public static void terrModCountNew(Set <TerritoryModel__c> territoryModels) {
        List <AggregateResult> aggregateResults = [
                select sum(numberOfEmployees__c) total,TerritoryModel__c
                from Territory__c
                where TerritoryModel__r.id = :territoryModels
                group by TerritoryModel__c
        ];
        Map <ID, TerritoryModel__c> territoryMap = new Map <ID, TerritoryModel__c>(new List <TerritoryModel__c> (territoryModels));
        for (AggregateResult aggRes : aggregateResults) {
            System.debug(aggRes);
            territoryMap.get((Id) aggRes.get('TerritoryModel__c')).numberOfEmployees__c = (Decimal) aggRes.get('total');
            System.debug('model.numberOfEmployees__c = ' + (Decimal) aggRes.get('total'));
        }
        upsert territoryMap.values();
    }

//    public static void terrCount(Set <Territory__c> territory) {
//        System.debug(territory);
//        Set <Id> terModIds = new Set <ID> ();
//        for (Territory__c t : territory) {
//            System.debug(t.Id);
//            if (t.id != null) {
//                AggregateResult a = [
//                        select sum(numberOfEmployees) total
//                        from account
//                        where Territory__r.id = :t.id
//                ][0];
//                System.debug(a);
//                t.numberOfEmployees__c = (Decimal) a.get('total');
//                System.debug('t.numberOfEmployees__c = ' + t.numberOfEmployees__c);
//            }
//            if (t.TerritoryModel__r != null) {
//                terModIds.add(t.TerritoryModel__c);
//            }
//        }
//        upsert new List <Territory__c> (territory);
//        if (terModIds.size() > 0) {
//            Set <TerritoryModel__c> tModel = new Set <TerritoryModel__c> ([SELECT numberOfEmployees__c from TerritoryModel__c where id in :terModIds]);
//            terrModCount(tModel);
//        }
//    }
//
//    public static void terrModCount(Set <TerritoryModel__c> territoryModels) {
//        for (TerritoryModel__c model : territoryModels) {
//            AggregateResult a = [select sum(numberOfEmployees__c) total from Territory__c where TerritoryModel__r.Id = :model.id][0];
//            System.debug(a);
//            model.numberOfEmployees__c = (Decimal) a.get('total');
//            System.debug('model.numberOfEmployees__c' + model.numberOfEmployees__c);
//        }
//        System.debug(territoryModels);
//        upsert new List <TerritoryModel__c> (territoryModels);
//    }

}