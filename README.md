# Oracle Service Bus Customer Service

A SOAP-based customer management service built with **Oracle Service Bus 12c**, integrating with an **Oracle Database** through **JCA Database Adapters** and stored procedures.

The project demonstrates service orchestration, XML schema validation, XQuery transformations, database integration, operation-based routing, and centralized SOAP fault handling in Oracle Service Bus.

## Technologies

- Oracle Service Bus 12c (12.2.1.4)
- Oracle WebLogic Server
- Oracle Database
- JCA Database Adapter
- SOAP 1.1
- WSDL
- XSD
- XQuery
- PL/SQL
- Maven
- Git / GitHub

## Current Operations

### CreateCustomer

Creates a customer in the Oracle database.

The operation:

1. Receives a SOAP request.
2. Validates the request against the service XSD.
3. Transforms the service request into the format required by the JCA Database Adapter.
4. Invokes the `CREATE_CUSTOMER` stored procedure.
5. Transforms the database response into the public service response.
6. Returns the generated customer ID and operation status.

### GetCustomer

Retrieves an existing customer by customer ID.

The operation:

1. Receives and validates the customer ID.
2. Transforms the SOAP request into the database adapter request.
3. Invokes the `GET_CUSTOMER` stored procedure.
4. Transforms the database response into the service response.
5. Returns the customer ID, first name, last name, and email address.

### UpdateCustomer

Updates an existing customer by customer ID.

The operation:

1. Receives and validates the customer ID and updated customer data.
2. Transforms the SOAP request into the database adapter request.
3. Invokes the `UPDATE_CUSTOMER` stored procedure.
4. Verifies that the customer exists and updates the customer record.
5. Returns the customer ID and a success status confirming the update.

### DeleteCustomer

Deletes an existing customer by customer ID.

The operation:

1. Receives and validates the customer ID.
2. Transforms the SOAP request into the database adapter request.
3. Invokes the `DELETE_CUSTOMER` stored procedure.
4. Verifies that the customer exists and deletes the customer record.
5. Returns a success status confirming the deletion.

## Architecture

```text
SOAP Client
    |
    v
CustomerProxyService
    |
    v
CustomerProxyServicePipeline
    |
    +-- Request Validation
    |
    +-- XQuery Request Transformation
    |
    +-- Operation Routing
    |
    v
Business Service
    |
    v
JCA Database Adapter
    |
    v
Oracle Stored Procedure
    |
    v
Oracle Database
```

Responses return through the pipeline where the database adapter output is transformed into the public SOAP response.

## Service Design

The service exposes multiple customer operations through a single proxy service and WSDL.

Implemented operations:

```text
CreateCustomer
GetCustomer
UpdateCustomer
DeleteCustomer
```

The pipeline uses the OSB operation context to route each request through the appropriate processing flow while maintaining a common service endpoint.

Each operation has its own request processing flow, database integration, response transformation, and operation-specific fault handling while sharing the same public customer service contract.

## XML Validation

Requests are validated using XSD schemas before database invocation.

Reusable schema definitions are separated from operation-specific request and response schemas.

Examples include:

```text
XSD/
├── Common/
│   ├── CustomerType.xsd
│   ├── CustomerResponseType.xsd
│   └── NonEmptyString.xsd
├── Request/
│   ├── CreateCustomerRequest.xsd
│   ├── GetCustomerRequest.xsd
│   ├── UpdateCustomerRequest.xsd
│   └── DeleteCustomerRequest.xsd
└── Response/
    ├── CreateCustomerResponse.xsd
    ├── GetCustomerResponse.xsd
    ├── UpdateCustomerResponse.xsd
    └── DeleteCustomerResponse.xsd
```

This allows common customer structures and validation rules to be reused across operations.

Request validation prevents invalid messages from reaching the database integration layer and allows validation failures to be returned as controlled SOAP faults.

## XQuery Transformations

XQuery transformations decouple the public SOAP contract from the database adapter contract.

The service contains transformations for:

```text
CreateCustomerRequest
CreateCustomerResponse
GetCustomerRequest
GetCustomerResponse
UpdateCustomerRequest
UpdateCustomerResponse
DeleteCustomerRequest
DeleteCustomerResponse
```

Request transformations convert the public service message into the structure required by the corresponding JCA Database Adapter.

Response transformations convert the database adapter result into the public SOAP response.

This allows the external service contract and internal database integration format to evolve independently.

## Database Integration

Database operations are exposed to OSB through JCA Database Adapters.

Stored procedures:

```sql
CREATE_CUSTOMER
GET_CUSTOMER
UPDATE_CUSTOMER
DELETE_CUSTOMER
```

Each database operation uses its own adapter and Business Service, keeping database integrations separated by responsibility.

The JCA Database Adapters invoke the corresponding PL/SQL stored procedures and isolate the OSB service layer from direct database access.

## Error Handling

The service implements centralized error handling at the pipeline level.

Errors are routed according to the current service operation so that each operation can return an appropriate controlled SOAP fault instead of exposing raw OSB, JCA, or Oracle Database errors to the consumer.

Handled scenarios include:

- Invalid or missing customer data
- Invalid customer IDs
- Duplicate customer email addresses
- Customer not found
- Unexpected service/database errors

Request validation failures are translated into operation-specific `VALIDATION_ERROR` SOAP faults.

Database `CUSTOMER_NOT_FOUND` errors are detected and translated into controlled operation-specific SOAP faults for operations such as GetCustomer, UpdateCustomer, and DeleteCustomer.

Example controlled SOAP fault:

```xml
<soapenv:Fault>
    <faultcode>soapenv:Client</faultcode>
    <faultstring>Customer not found</faultstring>
    <detail>
        <cus:GetCustomerError>
            <cus:Code>CUSTOMER_NOT_FOUND</cus:Code>
            <cus:Message>
                No customer exists with the provided CustomerId
            </cus:Message>
        </cus:GetCustomerError>
    </detail>
</soapenv:Fault>
```

This prevents internal Oracle, JCA, and OSB implementation details from being exposed through the public service contract.

## Project Structure

```text
CustomerService/
├── BusinessService/
├── ProxyService/
├── Resources/
├── WSDL/
├── XQuery/
├── XSD/
│   ├── Common/
│   ├── Request/
│   └── Response/
└── pom.xml
```

## Development Status

The core CRUD service is complete.

Implemented:

- [x] CreateCustomer
- [x] GetCustomer
- [x] UpdateCustomer
- [x] DeleteCustomer

The project implements a full CRUD customer service while demonstrating an end-to-end Oracle Service Bus integration architecture.