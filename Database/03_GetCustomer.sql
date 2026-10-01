-- Retrieves an existing customer identified by CUSTOMER_ID.
-- Returns the customer ID, first name, last name, and email address.

CREATE OR REPLACE PROCEDURE GET_CUSTOMER (
    P_CUSTOMER_ID     IN NUMBER,
    P_OUT_CUSTOMER_ID OUT NUMBER,
    P_FIRST_NAME      OUT VARCHAR2,
    P_LAST_NAME       OUT VARCHAR2,
    P_EMAIL           OUT VARCHAR2
)
AS
BEGIN
    SELECT
        CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME,
        EMAIL
    INTO
        P_OUT_CUSTOMER_ID,
        P_FIRST_NAME,
        P_LAST_NAME,
        P_EMAIL
    FROM CUSTOMER
    WHERE CUSTOMER_ID = P_CUSTOMER_ID;
END;
/