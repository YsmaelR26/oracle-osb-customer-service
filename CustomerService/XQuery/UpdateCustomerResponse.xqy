xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://osb.training/customer";
(:: import schema at "../XSD/Request/UpdateCustomerRequest.xsd", 
                     "../XSD/Response/UpdateCustomerResponse.xsd" ::)

declare variable $Request as element() (:: schema-element(ns1:UpdateCustomerRequest) ::) external;

declare function local:transformOutputParameters($Request as element() (:: schema-element(ns1:UpdateCustomerRequest) ::)) as element() (:: schema-element(ns1:UpdateCustomerResponse) ::) {
    <ns1:UpdateCustomerResponse>
        <ns1:CustomerId>{fn:data($Request/ns1:CustomerId)}</ns1:CustomerId>
        <ns1:ResponseStatus>
            <ns1:Status>SUCCESS</ns1:Status>
            <ns1:Message>Customer updated successfully</ns1:Message>
        </ns1:ResponseStatus>
    </ns1:UpdateCustomerResponse>
};

local:transformOutputParameters($Request)
