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



## Architecture



```text

SOAP Client

&#x20;   |

&#x20;   v

CustomerProxyService

&#x20;   |

&#x20;   v

CustomerProxyServicePipeline

&#x20;   |

&#x20;   +-- Request Validation

&#x20;   |

&#x20;   +-- XQuery Request Transformation

&#x20;   |

&#x20;   +-- Operation Routing

&#x20;   |

&#x20;   v

Business Service

&#x20;   |

&#x20;   v

JCA Database Adapter

&#x20;   |

&#x20;   v

Oracle Stored Procedure

&#x20;   |

&#x20;   v

Oracle Database

```



Responses return through the pipeline where the database adapter output is transformed into the public SOAP response.



## Service Design



The service exposes multiple customer operations through a single proxy service and WSDL.



Current operations:



```text

CreateCustomer

GetCustomer

```



Additional CRUD operations are planned as the project evolves.



The pipeline uses the OSB operation context to route each request through the appropriate processing flow while maintaining a common service endpoint.



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

│   └── GetCustomerRequest.xsd

└── Response/

&#x20;   ├── CreateCustomerResponse.xsd

&#x20;   └── GetCustomerResponse.xsd

```



This allows common customer structures and validation rules to be reused across operations.



## XQuery Transformations



XQuery transformations decouple the public SOAP contract from the database adapter contract.



The service currently contains transformations for:



```text

CreateCustomerRequest

CreateCustomerResponse

GetCustomerRequest

GetCustomerResponse

```



This allows the external service contract and internal database integration format to evolve independently.



## Database Integration



Database operations are exposed to OSB through JCA Database Adapters.



Current stored procedures:



```sql

CREATE_CUSTOMER

GET_CUSTOMER

```



Each database operation uses its own adapter and Business Service, keeping database integrations separated by responsibility.



## Error Handling



The service implements centralized error handling at the pipeline level.



Errors are routed according to the current service operation so that each operation can return an appropriate SOAP fault instead of exposing raw OSB, JCA, or Oracle Database errors to the consumer.



Handled scenarios currently include:



- Invalid or missing customer data

- Invalid customer IDs

- Duplicate customer email addresses

- Customer not found

- Unexpected service/database errors



Example controlled SOAP fault:



```xml

<soapenv:Fault>

&#x20;   <faultcode>soapenv:Client</faultcode>

&#x20;   <faultstring>Customer not found</faultstring>

&#x20;   <detail>

&#x20;       <cus:GetCustomerError>

&#x20;           <cus:Code>CUSTOMER_NOT_FOUND</cus:Code>

&#x20;           <cus:Message>

&#x20;               No customer exists with the provided CustomerId

&#x20;           </cus:Message>

&#x20;       </cus:GetCustomerError>

&#x20;   </detail>

</soapenv:Fault>

```



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



The service is currently under active development.



Implemented:



- [x] CreateCustomer

- [x] GetCustomer



Planned:



- [ ] UpdateCustomer

- [ ] DeleteCustomer



The goal is to complete a full CRUD customer service while demonstrating an end-to-end Oracle Service Bus integration architecture.

