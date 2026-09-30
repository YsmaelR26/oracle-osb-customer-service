xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://osb.training/customer";
(:: import schema at "../XSD/Request/CreateCustomerRequest.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateCustomerDBAdapter";
(:: import schema at "../Resources/CreateCustomerDBAdapter_sp.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:CreateCustomerRequest) ::) external;

declare function local:transformInputParameters($request as element() (:: schema-element(ns1:CreateCustomerRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_FIRST_NAME>{fn:data($request/ns1:PrimaryCustomer/ns1:FirstName)}</ns2:P_FIRST_NAME>
        <ns2:P_LAST_NAME>{fn:data($request/ns1:PrimaryCustomer/ns1:LastName)}</ns2:P_LAST_NAME>
        <ns2:P_EMAIL>{fn:data($request/ns1:PrimaryCustomer/ns1:Email)}</ns2:P_EMAIL>
    </ns2:InputParameters>
};

local:transformInputParameters($request)
