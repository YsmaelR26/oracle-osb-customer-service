xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://osb.training/customer";
(:: import schema at "../XSD/Response/GetCustomerResponse.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDBAdapter";
(:: import schema at "../Resources/GetCustomerDBAdapter_sp.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:transformGetCustomerResponse($response as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:GetCustomerResponse) ::) {
    <ns2:GetCustomerResponse>
        <ns2:CustomerId>{fn:data($response/ns1:P_OUT_CUSTOMER_ID)}</ns2:CustomerId>
        <ns2:PrimaryCustomer>
            <ns2:FirstName>{fn:data($response/ns1:P_FIRST_NAME)}</ns2:FirstName>
            <ns2:LastName>{fn:data($response/ns1:P_LAST_NAME)}</ns2:LastName>
            <ns2:Email>{fn:data($response/ns1:P_EMAIL)}</ns2:Email>
        </ns2:PrimaryCustomer>
    </ns2:GetCustomerResponse>
};

local:transformGetCustomerResponse($response)
