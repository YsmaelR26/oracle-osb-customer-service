xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://osb.training/customer";
(:: import schema at "../XSD/Request/UpdateCustomerRequest.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/UpdateCustomerDBAdapter";
(:: import schema at "../Resources/UpdateCustomerDBAdapter_sp.xsd" ::)

declare variable $Request as element() (:: schema-element(ns1:UpdateCustomerRequest) ::) external;

declare function local:transformInputParameters($Request as element() (:: schema-element(ns1:UpdateCustomerRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_CUSTOMER_ID>{fn:data($Request/ns1:CustomerId)}</ns2:P_CUSTOMER_ID>
        <ns2:P_FIRST_NAME>{fn:data($Request/ns1:PrimaryCustomer/ns1:FirstName)}</ns2:P_FIRST_NAME>
        <ns2:P_LAST_NAME>{fn:data($Request/ns1:PrimaryCustomer/ns1:LastName)}</ns2:P_LAST_NAME>
        <ns2:P_EMAIL>{fn:data($Request/ns1:PrimaryCustomer/ns1:Email)}</ns2:P_EMAIL>
    </ns2:InputParameters>
};

local:transformInputParameters($Request)
