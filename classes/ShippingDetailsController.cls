public with sharing class ShippingDetailsController {
    @AuraEnabled(cacheable=true)
    public static ShippingStatusResponse getShippingStatus(String trackingNumber) {
        HttpRequest request = new HttpRequest();
        String endpoint = 'https://merzcommunities--tina.sandbox.my.salesforce-sites.com/services/apexrest/mockShipmentStatus';
        if(String.isNotBlank(trackingNumber)) {
            endpoint += '?trackingNumber=' + EncodingUtil.urlEncode(trackingNumber, 'UTF-8');
        }
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            return new ShippingStatusResponse((String)Json.deserializeStrict(response.getBody(), String.class), null, null);
        } else {
            return new ShippingStatusResponse(null, 'API_ERROR', (String)Json.deserializeStrict(response.getBody(), String.class));
        }
    }

    public class ShippingStatusResponse {
        @AuraEnabled
        public String shippingStatus;
        @AuraEnabled
        public String errorCode;
        @AuraEnabled
        public String errorMessage;
        public ShippingStatusResponse(String shippingStatus, String errorCode, String errorMessage) {
            this.shippingStatus = shippingStatus;
            this.errorCode = errorCode;
            this.errorMessage = errorMessage;
        }
    }
}