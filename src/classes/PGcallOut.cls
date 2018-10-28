/**
 * Created by Serhii on 07.10.2018.
 */

public with sharing class PGcallOut {

    public static HttpResponse makeGetCallout() {
        HttpRequest request=new HttpRequest();
        request.setEndPoint('https://cunning-otter-gqxdzx-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + '0011t000005CVaXAAW');
        request.setHeader('Authorization','Bearer '+token());
        request.setHeader('Content-Type','application/json');
        request.setMethod('GET');
        Http hp=new Http();
        HttpResponse response=new HttpResponse();
        response=hp.send(request);
        System.debug('response'+response.getBody());
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            System.debug(results.values());
            List<Object> accs = new List<Object> (results.values());
            System.debug('Received the following account: ' + accs.get(0));
            for (Object a: accs) {
                System.debug(a);
            }
        }
        return response;
    }

    public static HttpResponse makePostCallout() {
        Http hp = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://cunning-otter-gqxdzx-dev-ed.my.salesforce.com/services/apexrest/Accounts/' );
        request.setMethod('POST');
        request.setHeader('Authorization','Bearer '+token());
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name":"qq2", "description":"qqqqqqqqqqqqqqqqqqqqqqqqqq"}');
        HttpResponse response = hp.send(request);
        if (response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('OK');
        }
        return response;
    }

    private static String token(){
        String endpoint='https://login.salesforce.com/services/oauth2/token';
        String username = 'uaserge2@cunning-otter-gqxdzx.com';
        String password = 'flgrbu81';
        String ClientId= '3MVG9fTLmJ60pJ5IRqjIsrVhIHGUbBpk_1PVZLlqzB1TqqKCqJ0Fs8x1Usc4F5HnOi3GBX.AE4IPSUV5Uyfta';
        String ClientSecret = '7877506296922383275';
        Httprequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setBody('grant_type=password' +
                '&client_id=' + ClientId +
                '&client_secret=' + ClientSecret +
                '&username=' + username +
                '&password=' + password
        );
        req.setEndpoint(endpoint);
        Http http = new Http();
        HttpResponse res= http.send(req);
        system.debug('body:'+res.getBody());
        JSONParser parser = JSON.createParser(res.getBody());
        String accessToken ;
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                String fieldName = parser.getText();
                parser.nextToken();
                System.debug('fieldName'+fieldName);
                if (fieldName == 'access_token') {
                    accessToken = parser.getText();
                }
            }
        }
        return accessToken;
    }


}