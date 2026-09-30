xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://osb.training/customer";
(:: import schema at "../XSD/Request/GetCustomerRequest.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerDBAdapter";
(:: import schema at "../Resources/GetCustomerDBAdapter_sp.xsd" ::)

declare variable $GetCustomerRequest as element() (:: schema-element(ns1:GetCustomerRequest) ::) external;

declare function local:transformGetCustomerRequest($GetCustomerRequest as element() (:: schema-element(ns1:GetCustomerRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_CUSTOMER_ID>{fn:data($GetCustomerRequest/ns1:CustomerId)}</ns2:P_CUSTOMER_ID>
    </ns2:InputParameters>
};

local:transformGetCustomerRequest($GetCustomerRequest)
