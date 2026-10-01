\# Database



This directory contains the Oracle Database objects required by the Oracle Service Bus Customer Service.



\## Database Objects



The service uses a `CUSTOMER` table and four PL/SQL stored procedures:



\- `CREATE\_CUSTOMER`

\- `GET\_CUSTOMER`

\- `UPDATE\_CUSTOMER`

\- `DELETE\_CUSTOMER`



\## Installation



Execute the scripts in the following order:



1\. `01\_CreateTable.sql`

2\. `02\_CreateCustomer.sql`

3\. `03\_GetCustomer.sql`

4\. `04\_UpdateCustomer.sql`

5\. `05\_DeleteCustomer.sql`



The table script creates the `CUSTOMER` table, including the identity-based customer ID, primary key, and unique email constraint.



The remaining scripts create the stored procedures used by the JCA Database Adapters in Oracle Service Bus.



\## OSB Integration



Oracle Service Bus accesses these stored procedures through JCA Database Adapters.



Each CRUD operation uses its own Database Adapter and Business Service, separating the database integration for each operation.



The OSB environment must have the appropriate database connection and JCA datasource/JNDI configuration before the adapters can invoke these procedures.

