xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://osb.training/customer";
(:: import schema at "../XSD/Response/CreateCustomerResponse.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateCustomerDBAdapter";
(:: import schema at "../Resources/CreateCustomerDBAdapter_sp.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:transformCreateCustomerResponse($response as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:CreateCustomerResponse) ::) {
    <ns2:CreateCustomerResponse>
        <ns2:CustomerId>{fn:data($response/ns1:P_CUSTOMER_ID)}</ns2:CustomerId>
        <ns2:ResponseStatus>
            <ns2:Status>SUCCESS</ns2:Status>
            <ns2:Message>Customer created successfully</ns2:Message>
        </ns2:ResponseStatus>
    </ns2:CreateCustomerResponse>
};

local:transformCreateCustomerResponse($response)
