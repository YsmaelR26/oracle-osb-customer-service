xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://osb.training/customer";
(:: import schema at "../XSD/Response/DeleteCustomerResponse.xsd" ::)


declare function local:transformOutputParameters() as element() (:: schema-element(ns1:DeleteCustomerResponse) ::) {
    <ns1:DeleteCustomerResponse>
        <ns1:ResponseStatus>
            <ns1:Status>SUCCESS</ns1:Status>
            <ns1:Message>Customer deleted successfully</ns1:Message>
        </ns1:ResponseStatus>
    </ns1:DeleteCustomerResponse>
};

local:transformOutputParameters()
