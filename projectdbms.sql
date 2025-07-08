


-- 1. Create BANK Table
CREATE TABLE BANK (
    B_Code VARCHAR2(10) PRIMARY KEY,
    City VARCHAR2(50) NOT NULL,
    B_Name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(255)
);

-- 2. Create BRANCH Table
CREATE TABLE BRANCH (
    Branch_code VARCHAR2(10) PRIMARY KEY,
    Branch_name VARCHAR2(100) NOT NULL,
    Address VARCHAR2(255),
    B_Code VARCHAR2(10) NOT NULL,
    FOREIGN KEY (B_Code) REFERENCES BANK(B_Code)
);

-- 3. Create CUSTOMERX Table 
CREATE TABLE CUSTOMERX (
    C_ID VARCHAR2(10) PRIMARY KEY,
    Customerx VARCHAR2(100) NOT NULL,
    Address VARCHAR2(255),
    Mobile_No VARCHAR2(15) UNIQUE
);

-- 4. Create EMPLOYEE Table
CREATE TABLE EMPLOYEE (
    E_ID VARCHAR2(10) PRIMARY KEY,
    E_Name VARCHAR2(100) NOT NULL,
    Position VARCHAR2(50),
    Salary NUMBER(10, 2),
    Hire_Date DATE,
    Branch_code VARCHAR2(10) NOT NULL,
    Mobile_No VARCHAR2(15) UNIQUE,
    FOREIGN KEY (Branch_code) REFERENCES BRANCH(Branch_code)
);

-- 5. Create BANK_ACCOUNT Table
CREATE TABLE BANK_ACCOUNT (
    Account_No VARCHAR2(20) PRIMARY KEY,
    Balance NUMBER(15, 2) DEFAULT 0 CHECK (Balance >= 0),
    Branch_code VARCHAR2(10) NOT NULL,
    C_ID VARCHAR2(10) NOT NULL,
    Account_Type VARCHAR2(20) CHECK (Account_Type IN ('Saving', 'Current', 'Fixed Deposit')),
    FOREIGN KEY (Branch_code) REFERENCES BRANCH(Branch_code),
    FOREIGN KEY (C_ID) REFERENCES CUSTOMERX(C_ID) -- Changed to reference CUSTOMERX
);

-- 6. Create LOANS Table
CREATE TABLE LOANS (
    Loan_No VARCHAR2(10) PRIMARY KEY,
    Amount NUMBER(15, 2) NOT NULL CHECK (Amount > 0),
    Interest_Rate NUMBER(5, 4) NOT NULL CHECK (Interest_Rate > 0),
    C_ID VARCHAR2(10) NOT NULL,
    E_ID VARCHAR2(10), -- Assuming an employee might be assigned to a loan, but not strictly mandatory based on ER
    FOREIGN KEY (C_ID) REFERENCES CUSTOMERX(C_ID), -- Changed to reference CUSTOMERX
    FOREIGN KEY (E_ID) REFERENCES EMPLOYEE(E_ID)
);

-- 7. Create PAYMENT Table
CREATE TABLE PAYMENT (
    P_Account VARCHAR2(20),
    P_Date DATE,
    Loan_No VARCHAR2(10) NOT NULL,
    Amount NUMBER(15, 2) NOT NULL CHECK (Amount > 0),
    PRIMARY KEY (P_Account, P_Date), -- Composite primary key
    FOREIGN KEY (P_Account) REFERENCES BANK_ACCOUNT(Account_No),
    FOREIGN KEY (Loan_No) REFERENCES LOANS(Loan_No)
);

-- 8. Create CARD Table
CREATE TABLE CARD (
    Card_No VARCHAR2(20) PRIMARY KEY,
    Card_Type VARCHAR2(20) CHECK (Card_Type IN ('Debit Card', 'Credit Card', 'Prepaid')),
    C_ID VARCHAR2(10) NOT NULL,
    FOREIGN KEY (C_ID) REFERENCES CUSTOMERX(C_ID) -- Changed to reference CUSTOMERX
);

-- 9. Create TRANSACTION Table
CREATE TABLE TRANSACTION (
    T_ID VARCHAR2(20) PRIMARY KEY,
    Account_No VARCHAR2(20) NOT NULL,
    T_Date DATE NOT NULL,
    Amount NUMBER(15, 2) NOT NULL CHECK (Amount >= 0),
    Modex VARCHAR2(50),
    Status VARCHAR2(20) CHECK (Status IN ('success', 'failed', 'pending')),
    Card_No VARCHAR2(20), -- Optional, as not all transactions use a card
    FOREIGN KEY (Account_No) REFERENCES BANK_ACCOUNT(Account_No),
    FOREIGN KEY (Card_No) REFERENCES CARD(Card_No)
);
DROP TABLE TRANSACTION;
DROP TABLE PAYMENT;
DROP TABLE CARD;
DROP TABLE LOANS;
DROP TABLE BANK_ACCOUNT;
DROP TABLE EMPLOYEE;
DROP TABLE CUSTOMERX; 
DROP TABLE BRANCH;
DROP TABLE BANK;

-- Insert Sample Data

-- Insert into BANK
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B101', 'Patiala', 'State Bank', 'Near Bus Stand, Patiala');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B102', 'Chandigarh', 'Punjab Bank', 'Sector 17, Chandigarh');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B103', 'Ludhiana', 'Central Bank', 'Civil Lines, Ludhiana');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B104', 'Amritsar', 'Union Bank', 'Hall Bazaar, Amritsar');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B105', 'Patiala', 'Axis Bank', 'Mall Road, Patiala');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B106', 'Jalandhar', 'HDFC Bank', 'Model Town, Jalandhar');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B107', 'Chandigarh', 'ICICI Bank', 'Sector 9, Chandigarh');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B108', 'Ludhiana', 'PNB Bank', 'Sarabha Nagar, Ludhiana');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B109', 'Amritsar', 'Bank of India', 'Lawrence Road, Amritsar');
INSERT INTO BANK (B_Code, City, B_Name, Address) VALUES ('B110', 'Patiala', 'Canara Bank', 'Adalat Bazaar, Patiala');

-- Insert into BRANCH
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR001', 'Patiala Main', 'The Mall, Patiala', 'B101');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR002', 'CHD Sector 17', 'Sector 17 Market, Chandigarh', 'B102');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR003', 'LDH Civil Lines', 'Civil Lines Area, Ludhiana', 'B103');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR004', 'ASR Hall Gate', 'Hall Bazaar Entry, Amritsar', 'B104');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR005', 'PTL Model Town', 'Model Town Extension, Patiala', 'B105');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR006', 'JAL City', 'Near Railway Station, Jalandhar', 'B106');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR007', 'CHD Sector 11', 'Sector 11 Inner Road, Chandigarh', 'B107');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR008', 'LDH Sarabha', 'Sarabha Nagar Market, Ludhiana', 'B108');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR009', 'ASR Golden', 'Golden Temple Road, Amritsar', 'B109');
INSERT INTO BRANCH (Branch_code, Branch_name, Address, B_Code) VALUES ('BR010', 'PTL Adalat', 'Inside Adalat Bazaar, Patiala', 'B110');

-- Insert into CUSTOMERX -- Changed from CUSTOMER to CUSTOMERX
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST01', 'Aman Singh', '123 Green Avenue, Patiala', '9876543210');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST02', 'Priya Verma', 'H.No. 45, Sector 18, Chandigarh', '8765432109');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST03', 'Rohan Gill', '56 Link Road, Ludhiana', '7654321098');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST04', 'Simran Kaur', '78 Mall Road, Amritsar', '6543210987');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST05', 'Vivek Sharma', '90 Rose Lane, Patiala', '5432109876');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST06', 'Neha Gupta', '21 Model Town, Jalandhar', '4321098765');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST07', 'Arjun Mehra', '34 Sector 10, Chandigarh', '3210987654');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST08', 'Sneha Rani', '67 Ferozepur Road, Ludhiana', '2109876543');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST09', 'Tarun Bajaj', '89 Circular Road, Amritsar', '1098765432');
INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No) VALUES ('CUST10', 'Anjali Devi', '101 New Colony, Patiala', '9012345678');

-- Insert into EMPLOYEE
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP001', 'Rajesh Kumar', 'Manager', 50000, TO_DATE('2020-08-15', 'YYYY-MM-DD'), 'BR001', '9988776655');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP002', 'Seema Verma', 'Clerk', 25000, TO_DATE('2021-01-20', 'YYYY-MM-DD'), 'BR002', '8899776655');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP003', 'Harpreet Singh', 'Accountant', 35000, TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'BR003', '7788996655');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP004', 'Priya Sharma', 'Loan Officer', 40000, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'BR004', '6677889955');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP005', 'Amit Patel', 'Branch Manager', 55000, TO_DATE('2019-11-22', 'YYYY-MM-DD'), 'BR005', '5566778899');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP006', 'Kiran Bedi', 'Teller', 22000, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'BR006', '4455667788');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP007', 'Sanjay Gupta', 'Assistant Manager', 45000, TO_DATE('2021-09-18', 'YYYY-MM-DD'), 'BR007', '3344556677');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP008', 'Ritu Singh', 'Cashier', 28000, TO_DATE('2022-12-05', 'YYYY-MM-DD'), 'BR008', '2233445566');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP009', 'Vikas Khanna', 'IT Officer', 48000, TO_DATE('2023-06-25', 'YYYY-MM-DD'), 'BR009', '1122334455');
INSERT INTO EMPLOYEE (E_ID, E_Name, Position, Salary, Hire_Date, Branch_code, Mobile_No) VALUES ('EMP010', 'Pooja Joshi', 'Customer Service', 30000, TO_DATE('2024-02-10', 'YYYY-MM-DD'), 'BR010', '9182736450');

-- Insert into BANK_ACCOUNT
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1001', 15000, 'BR001', 'CUST01', 'Saving');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1002', 250000, 'BR002', 'CUST02', 'Current');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1003', 7500, 'BR003', 'CUST03', 'Saving');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1004', 120000, 'BR004', 'CUST04', 'Current');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1005', 50000, 'BR005', 'CUST05', 'Saving');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1006', 300000, 'BR006', 'CUST06', 'Current');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1007', 9000, 'BR007', 'CUST07', 'Saving');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1008', 180000, 'BR008', 'CUST08', 'Current');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1009', 60000, 'BR009', 'CUST09', 'Saving');
INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type) VALUES ('ACC1010', 220000, 'BR010', 'CUST10', 'Current');

-- Insert into LOANS
-- Assigning EMP004 (Loan Officer) to all loans for sample data
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2001', 50000, 0.10, 'CUST01', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2002', 150000, 0.12, 'CUST03', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2003', 75000, 0.09, 'CUST05', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2004', 200000, 0.11, 'CUST07', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2005', 100000, 0.105, 'CUST09', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2006', 60000, 0.13, 'CUST02', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2007', 180000, 0.115, 'CUST04', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2008', 90000, 0.095, 'CUST06', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2009', 250000, 0.125, 'CUST08', 'EMP004');
INSERT INTO LOANS (Loan_No, Amount, Interest_Rate, C_ID, E_ID) VALUES ('LN2010', 120000, 0.10, 'CUST10', 'EMP004');

-- Insert into PAYMENT
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1001', TO_DATE('2025-05-10', 'YYYY-MM-DD'), 'LN2001', 5000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1003', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 'LN2002', 15000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1005', TO_DATE('2025-05-15', 'YYYY-MM-DD'), 'LN2003', 7500);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1007', TO_DATE('2025-05-08', 'YYYY-MM-DD'), 'LN2004', 20000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1009', TO_DATE('2025-05-11', 'YYYY-MM-DD'), 'LN2005', 10000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1002', TO_DATE('2025-05-13', 'YYYY-MM-DD'), 'LN2006', 6000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1004', TO_DATE('2025-05-16', 'YYYY-MM-DD'), 'LN2007', 18000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1006', TO_DATE('2025-05-09', 'YYYY-MM-DD'), 'LN2008', 9000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1008', TO_DATE('2025-05-14', 'YYYY-MM-DD'), 'LN2009', 25000);
INSERT INTO PAYMENT (P_Account, P_Date, Loan_No, Amount) VALUES ('ACC1010', TO_DATE('2025-05-17', 'YYYY-MM-DD'), 'LN2010', 12000);

-- Insert into CARD
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD001', 'Debit Card', 'CUST01');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD002', 'Credit Card', 'CUST02');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD003', 'Prepaid', 'CUST03');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD004', 'Debit Card', 'CUST04');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD005', 'Credit Card', 'CUST05');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD006', 'Prepaid', 'CUST06');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD007', 'Debit Card', 'CUST07');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD008', 'Credit Card', 'CUST08');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD009', 'Prepaid', 'CUST09');
INSERT INTO CARD (Card_No, Card_Type, C_ID) VALUES ('CARD010', 'Debit Card', 'CUST10');

-- Insert into TRANSACTION
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS001', 'ACC1001', TO_DATE('2025-05-16', 'YYYY-MM-DD'), 500, 'ATM', 'success', 'CARD001');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS002', 'ACC1002', TO_DATE('2025-05-16', 'YYYY-MM-DD'), 1000, 'Online Banking', 'success', 'CARD002');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS003', 'ACC1003', TO_DATE('2025-05-15', 'YYYY-MM-DD'), 200, 'POS', 'success', 'CARD003');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS004', 'ACC1004', TO_DATE('2025-05-15', 'YYYY-MM-DD'), 1500, 'ATM', 'success', 'CARD004');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS005', 'ACC1005', TO_DATE('2025-05-14', 'YYYY-MM-DD'), 750, 'Online Banking', 'success', 'CARD005');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS006', 'ACC1006', TO_DATE('2025-05-14', 'YYYY-MM-DD'), 300, 'POS', 'failed', 'CARD006');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS007', 'ACC1007', TO_DATE('2025-05-13', 'YYYY-MM-DD'), 1200, 'ATM', 'success', 'CARD007');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS008', 'ACC1008', TO_DATE('2025-05-13', 'YYYY-MM-DD'), 900, 'Online Banking', 'pending', 'CARD008');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS009', 'ACC1009', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 400, 'POS', 'success', 'CARD009');
INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No) VALUES ('TRANS010', 'ACC1010', TO_DATE('2025-05-12', 'YYYY-MM-DD'), 1800, 'ATM', 'success', 'CARD010');

-- Commit the transactions
COMMIT;
-- PL/SQL Functions and Procedures for Bank Database

-- 1. Function to get Account Balance
-- This function takes an account number and returns the current balance.
CREATE OR REPLACE FUNCTION GET_ACCOUNT_BALANCE (
    p_account_no IN VARCHAR2
)
RETURN NUMBER
IS
    v_balance NUMBER(15, 2);
BEGIN
    -- Retrieve the balance for the given account number
    SELECT Balance
    INTO v_balance
    FROM BANK_ACCOUNT
    WHERE Account_No = p_account_no;

    -- Return the retrieved balance
    RETURN v_balance;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where account number is not found
        DBMS_OUTPUT.PUT_LINE('Error: Account number ' || p_account_no || ' not found.');
        RETURN NULL; -- Or raise an application-specific error
    WHEN OTHERS THEN
        -- Handle other potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RAISE; -- Re-raise the exception
END GET_ACCOUNT_BALANCE;
/

-- 2. Procedure for Deposit
-- This procedure handles depositing an amount into a given account.
-- It updates the account balance and records the transaction.
CREATE OR REPLACE PROCEDURE DEPOSIT_TO_ACCOUNT (
    p_account_no IN VARCHAR2,
    p_amount IN NUMBER,
    p_mode IN VARCHAR2
)
IS
    v_current_balance NUMBER(15, 2);
    v_t_id VARCHAR2(20);
BEGIN
    -- Validate the deposit amount
    IF p_amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Deposit amount must be positive.');
        RETURN;
    END IF;

    -- Check if the account exists and get the current balance
    SELECT Balance INTO v_current_balance
    FROM BANK_ACCOUNT
    WHERE Account_No = p_account_no
    FOR UPDATE OF Balance; -- Lock the row for update to prevent race conditions

    -- Update the account balance
    UPDATE BANK_ACCOUNT
    SET Balance = Balance + p_amount
    WHERE Account_No = p_account_no;

    -- Generate a unique transaction ID (simple example, consider sequences in real projects)
    SELECT 'TRANS' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') || DBMS_RANDOM.STRING('U', 5) INTO v_t_id FROM dual;

    -- Record the transaction
    INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status)
    VALUES (v_t_id, p_account_no, SYSDATE, p_amount, p_mode, 'success');

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Deposit of ' || p_amount || ' to account ' || p_account_no || ' successful.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where account number is not found
        DBMS_OUTPUT.PUT_LINE('Error: Account number ' || p_account_no || ' not found.');
        ROLLBACK; -- Rollback the transaction
    WHEN OTHERS THEN
        -- Handle other potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred during deposit: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction
        RAISE; -- Re-raise the exception
END DEPOSIT_TO_ACCOUNT;
/

-- 3. Procedure for Withdrawal
-- This procedure handles withdrawing an amount from a given account.
-- It checks for sufficient balance, updates the balance, and records the transaction.
CREATE OR REPLACE PROCEDURE WITHDRAW_FROM_ACCOUNT (
    p_account_no IN VARCHAR2,
    p_amount IN NUMBER,
    p_mode IN VARCHAR2,
    p_card_no IN VARCHAR2 DEFAULT NULL -- Optional card number
)
IS
    v_current_balance NUMBER(15, 2);
    v_t_id VARCHAR2(20);
BEGIN
    -- Validate the withdrawal amount
    IF p_amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Withdrawal amount must be positive.');
        RETURN;
    END IF;

    -- Check if the account exists and get the current balance
    SELECT Balance INTO v_current_balance
    FROM BANK_ACCOUNT
    WHERE Account_No = p_account_no
    FOR UPDATE OF Balance; -- Lock the row for update

    -- Check for sufficient funds
    IF v_current_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient funds in account ' || p_account_no);
        -- Record failed transaction
         SELECT 'TRANS' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') || DBMS_RANDOM.STRING('U', 5) INTO v_t_id FROM dual;
         INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No)
         VALUES (v_t_id, p_account_no, SYSDATE, p_amount, p_mode, 'failed', p_card_no);
         COMMIT; -- Commit the failed transaction record
        RETURN;
    END IF;

    -- Update the account balance
    UPDATE BANK_ACCOUNT
    SET Balance = Balance - p_amount
    WHERE Account_No = p_account_no;

    -- Generate a unique transaction ID
    SELECT 'TRANS' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') || DBMS_RANDOM.STRING('U', 5) INTO v_t_id FROM dual;

    -- Record the transaction
    INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Modex, Status, Card_No)
    VALUES (v_t_id, p_account_no, SYSDATE, p_amount, p_mode, 'success', p_card_no);

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Withdrawal of ' || p_amount || ' from account ' || p_account_no || ' successful.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where account number is not found
        DBMS_OUTPUT.PUT_LINE('Error: Account number ' || p_account_no || ' not found.');
        ROLLBACK; -- Rollback the transaction
    WHEN OTHERS THEN
        -- Handle other potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred during withdrawal: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction
        RAISE; -- Re-raise the exception
END WITHDRAW_FROM_ACCOUNT;
/

-- 4. Procedure to Create a New Customer
-- This procedure adds a new customer to the CUSTOMERX table.
CREATE OR REPLACE PROCEDURE CREATE_NEW_CUSTOMER (
    p_c_id IN VARCHAR2,
    p_customerx_name IN VARCHAR2,
    p_address IN VARCHAR2,
    p_mobile_no IN VARCHAR2
)
IS
BEGIN
    -- Insert the new customer record
    INSERT INTO CUSTOMERX (C_ID, Customerx, Address, Mobile_No)
    VALUES (p_c_id, p_customerx_name, p_address, p_mobile_no);

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('New customer ' || p_customerx_name || ' with ID ' || p_c_id || ' created successfully.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        -- Handle case where C_ID or Mobile_No already exists
        DBMS_OUTPUT.PUT_LINE('Error: Customer ID or Mobile Number already exists.');
        ROLLBACK;
    WHEN OTHERS THEN
        -- Handle other potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred during customer creation: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END CREATE_NEW_CUSTOMER;
/

-- 5. Procedure to Create a New Bank Account
-- This procedure creates a new bank account for an existing customer in a specific branch.
CREATE OR REPLACE PROCEDURE CREATE_NEW_ACCOUNT (
    p_account_no IN VARCHAR2,
    p_branch_code IN VARCHAR2,
    p_c_id IN VARCHAR2,
    p_account_type IN VARCHAR2
)
IS
    v_customer_exists NUMBER;
    v_branch_exists NUMBER;
BEGIN
    -- Check if the customer exists
    SELECT COUNT(*)
    INTO v_customer_exists
    FROM CUSTOMERX
    WHERE C_ID = p_c_id;

    IF v_customer_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Customer with ID ' || p_c_id || ' does not exist.');
        RETURN;
    END IF;

    -- Check if the branch exists
    SELECT COUNT(*)
    INTO v_branch_exists
    FROM BRANCH
    WHERE Branch_code = p_branch_code;

    IF v_branch_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Error: Branch with code ' || p_branch_code || ' does not exist.');
        RETURN;
    END IF;

    -- Insert the new bank account record
    INSERT INTO BANK_ACCOUNT (Account_No, Balance, Branch_code, C_ID, Account_Type)
    VALUES (p_account_no, 0, p_branch_code, p_c_id, p_account_type); -- Starting balance is 0

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('New account ' || p_account_no || ' created successfully for customer ' || p_c_id || ' at branch ' || p_branch_code);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        -- Handle case where Account_No already exists
        DBMS_OUTPUT.PUT_LINE('Error: Account number ' || p_account_no || ' already exists.');
        ROLLBACK;
    WHEN OTHERS THEN
        -- Handle other potential errors
        DBMS_OUTPUT.PUT_LINE('An error occurred during account creation: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END CREATE_NEW_ACCOUNT;
/
-- Trigger to update the account balance after a transaction is inserted
-- This trigger fires AFTER each row INSERTED into the TRANSACTION table

CREATE OR REPLACE TRIGGER TRG_UPDATE_ACCOUNT_BALANCE
AFTER INSERT ON TRANSACTION
FOR EACH ROW
WHEN (NEW.Status = 'success') -- Only fire for successful transactions
DECLARE
    v_account_type VARCHAR2(20);
BEGIN
    -- Get the account type to determine if it's a Saving or Current account (assuming these are affected by transactions)
    SELECT Account_Type
    INTO v_account_type
    FROM BANK_ACCOUNT
    WHERE Account_No = :NEW.Account_No; -- :NEW refers to the newly inserted row

    -- Update the balance based on the transaction amount
    -- Assuming positive amounts are deposits and negative amounts are withdrawals
    -- In your current schema, Amount is always >= 0, so you might need
    -- a separate column or logic to indicate deposit/withdrawal type in TRANSACTION
    -- For this example, let's assume a positive amount is a deposit for simplicity
    -- A more robust design would involve a transaction type column.

    -- If you have a transaction type column (e.g., Transaction_Type IN ('Deposit', 'Withdrawal')):
    /*
    IF :NEW.Transaction_Type = 'Deposit' THEN
        UPDATE BANK_ACCOUNT
        SET Balance = Balance + :NEW.Amount
        WHERE Account_No = :NEW.Account_No;
    ELSIF :NEW.Transaction_Type = 'Withdrawal' THEN
        -- You would typically handle balance check BEFORE insertion in a procedure
        -- But if doing it here, you'd need to ensure sufficient funds
        UPDATE BANK_ACCOUNT
        SET Balance = Balance - :NEW.Amount
        WHERE Account_No = :NEW.Account_No;
    END IF;
    */

    -- Based on your current schema where Amount is always >= 0,
    -- let's assume inserting a transaction *always* means adding to the balance
    -- This might not be correct for withdrawals, which is why a procedure
    -- for withdrawal (like the one provided earlier) is generally better
    -- as it can check balance *before* the insert.

    -- A more realistic approach with your current schema and the provided procedures:
    -- The procedures DEPOSIT_TO_ACCOUNT and WITHDRAW_FROM_ACCOUNT already handle
    -- updating the balance. So, you might NOT need this trigger if all balance
    -- changes go through those procedures.

    -- However, if transactions could be inserted directly, this trigger could
    -- attempt to update. Let's refine this assuming Amount is the net change:
    -- If Amount > 0 it's a deposit, if Amount < 0 it's a withdrawal.
    -- Your schema has Amount >= 0, so this trigger is less useful for withdrawals
    -- unless you add a Transaction_Type column.

    -- Let's create a trigger that updates balance for successful transactions
    -- assuming Amount is the value of the transaction. This trigger is best
    -- used if the TRANSACTION table is populated by procedures that ensure
    -- the Amount is correct for the operation (positive for deposit, negative for withdrawal).
    -- Given your current schema, let's assume successful transactions with Amount > 0
    -- are deposits that need to increase the balance.

    IF :NEW.Amount > 0 THEN
        UPDATE BANK_ACCOUNT
        SET Balance = Balance + :NEW.Amount
        WHERE Account_No = :NEW.Account_No;
    END IF;

    -- Note: Handling withdrawals via trigger is tricky due to the need to check balance
    -- BEFORE the update. Procedures are better for withdrawal logic.

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Account not found (shouldn't happen if foreign key is enforced)
        DBMS_OUTPUT.PUT_LINE('Error in trigger: Account ' || :NEW.Account_No || ' not found.');
    WHEN OTHERS THEN
        -- Handle other errors
        DBMS_OUTPUT.PUT_LINE('Error in trigger: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20001, 'Error updating account balance: ' || SQLERRM);
END TRG_UPDATE_ACCOUNT_BALANCE;
/



-- Trigger to prevent withdrawal if account balance is insufficient
-- This trigger fires BEFORE each row INSERTED into the TRANSACTION table

CREATE OR REPLACE TRIGGER TRG_PREVENT_INSUFFICIENT_WITHDRAWAL
BEFORE INSERT ON TRANSACTION
FOR EACH ROW
-- This WHEN clause assumes 'Withdrawal' in the Mode indicates a withdrawal.
-- Adjust this condition based on how withdrawals are identified in your TRANSACTION table.
WHEN (NEW.Modex = 'Withdrawal')
DECLARE
    v_current_balance BANK_ACCOUNT.Balance%TYPE;
BEGIN
    -- Get the current balance for the account involved in the transaction
    SELECT Balance
    INTO v_current_balance
    FROM BANK_ACCOUNT
    WHERE Account_No = :NEW.Account_No; -- :NEW refers to the row being inserted

    -- Check if the current balance is less than the withdrawal amount
    IF v_current_balance < :NEW.Amount THEN
        -- If insufficient funds, raise an application error.
        -- This will prevent the INSERT operation from completing.
        RAISE_APPLICATION_ERROR(-20002, 'Insufficient funds for withdrawal from account ' || :NEW.Account_No);
    END IF;

    -- If the balance is sufficient, the trigger finishes without raising an error,
    -- and the INSERT operation is allowed to proceed.

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where account number is not found (should ideally be prevented by foreign key)
        -- Raising an error here will also prevent the transaction insertion.
        RAISE_APPLICATION_ERROR(-20003, 'Account number ' || :NEW.Account_No || ' not found for withdrawal.');
    WHEN OTHERS THEN
        -- Handle any other unexpected errors during the trigger execution
        RAISE_APPLICATION_ERROR(-20004, 'An unexpected error occurred during withdrawal check: ' || SQLERRM);
END TRG_PREVENT_INSUFFICIENT_WITHDRAWAL;
/
-- PL/SQL block using a cursor to apply interest to savings accounts

DECLARE
    -- Define a cursor to select Savings accounts
    CURSOR savings_accounts_cur IS
        SELECT Account_No, Balance
        FROM BANK_ACCOUNT
        WHERE Account_Type = 'Saving';

    -- Variables to hold data fetched by the cursor
    v_account_no BANK_ACCOUNT.Account_No%TYPE;
    v_balance BANK_ACCOUNT.Balance%TYPE;
    v_interest_rate NUMBER := 0.005; -- Example monthly interest rate (0.5%)
    v_interest_amount NUMBER(15, 2);

BEGIN
    -- Open the cursor
    OPEN savings_accounts_cur;

    -- Loop through each row returned by the cursor
    LOOP
        -- Fetch the next row into variables
        FETCH savings_accounts_cur INTO v_account_no, v_balance;

        -- Exit the loop when no more rows are found
        EXIT WHEN savings_accounts_cur%NOTFOUND;

        -- Calculate the interest amount
        v_interest_amount := v_balance * v_interest_rate;

        -- Update the account balance with the interest
        UPDATE BANK_ACCOUNT
        SET Balance = Balance + v_interest_amount
        WHERE Account_No = v_account_no;

        -- Optionally, record a transaction for the interest payment
        -- (You would need a transaction type like 'Interest Payment')
        /*
        INSERT INTO TRANSACTION (T_ID, Account_No, T_Date, Amount, Mode, Status)
        VALUES ('TRANS_INT_' || TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') || v_account_no,
                v_account_no, SYSDATE, v_interest_amount, 'System', 'success');
        */

        DBMS_OUTPUT.PUT_LINE('Applied interest of ' || v_interest_amount || ' to account ' || v_account_no);

    END LOOP;

    -- Close the cursor
    CLOSE savings_accounts_cur;

    -- Commit the changes
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Interest application process completed.');

EXCEPTION
    WHEN OTHERS THEN
        -- Handle any errors
        DBMS_OUTPUT.PUT_LINE('An error occurred during interest application: ' || SQLERRM);
        -- Rollback any changes made so far in case of error
        ROLLBACK;
        RAISE; -- Re-raise the exception
END;
/
-- PL/SQL block using a cursor to generate an account statement

DECLARE
    -- Variables to define the statement period and account
    p_account_no BANK_ACCOUNT.Account_No%TYPE := 'ACC1001'; -- Specify the account number
    p_start_date DATE := TO_DATE('2025-05-01', 'YYYY-MM-DD'); -- Specify the start date
    p_end_date DATE := TO_DATE('2025-05-31', 'YYYY-MM-DD'); -- Specify the end date

    -- Define a cursor to fetch transactions for the specified account and date range
    CURSOR account_statement_cur IS
        SELECT
            T_ID,
            T_Date,
            Amount,
            Modex,
            Status,
            Card_No
        FROM
            TRANSACTION
        WHERE
            Account_No = p_account_no
            AND T_Date BETWEEN p_start_date AND p_end_date
        ORDER BY
            T_Date, T_ID; -- Order by date and then transaction ID

    -- Variables to hold data fetched by the cursor
    v_t_id TRANSACTION.T_ID%TYPE;
    v_t_date TRANSACTION.T_Date%TYPE;
    v_amount TRANSACTION.Amount%TYPE;
    v_mode TRANSACTION.Modex%TYPE;
    v_status TRANSACTION.Status%TYPE;
    v_card_no TRANSACTION.Card_No%TYPE;

    -- Variable to hold the current account balance (optional, for displaying final balance)
    v_current_balance BANK_ACCOUNT.Balance%TYPE;

BEGIN
    -- Enable DBMS_OUTPUT to see the statement output
    DBMS_OUTPUT.ENABLE(NULL);

    -- Display statement header
    DBMS_OUTPUT.PUT_LINE('--- Account Statement for Account: ' || p_account_no || ' ---');
    DBMS_OUTPUT.PUT_LINE('Period: ' || TO_CHAR(p_start_date, 'YYYY-MM-DD') || ' to ' || TO_CHAR(p_end_date, 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(RPAD('T_ID', 10) || ' | ' || RPAD('Date', 10) || ' | ' || RPAD('Amount', 10) || ' | ' || RPAD('Mode', 20) || ' | ' || RPAD('Status', 10) || ' | ' || RPAD('Card_No', 15));
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');

    -- Open the cursor
    OPEN account_statement_cur;

    -- Loop through each transaction row
    LOOP
        -- Fetch the next row into variables
        FETCH account_statement_cur INTO v_t_id, v_t_date, v_amount, v_mode, v_status, v_card_no;

        -- Exit the loop when no more rows are found
        EXIT WHEN account_statement_cur%NOTFOUND;

        -- Display the transaction details (format as needed)
        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_t_id, 10) || ' | ' ||
            TO_CHAR(v_t_date, 'YYYY-MM-DD') || ' | ' ||
            RPAD(TO_CHAR(v_amount, 'FM9999999.00'), 10) || ' | ' || -- Format amount
            RPAD(v_mode, 20) || ' | ' ||
            RPAD(v_status, 10) || ' | ' ||
            RPAD(NVL(v_card_no, 'N/A'), 15) -- Display Card_No or 'N/A' if null
        );

    END LOOP;

    -- Close the cursor
    CLOSE account_statement_cur;

    -- Display the final balance (optional)
    -- Fetch the current balance after the statement period
    BEGIN
        SELECT Balance
        INTO v_current_balance
        FROM BANK_ACCOUNT
        WHERE Account_No = p_account_no;

        DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Current Balance as of ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD') || ': ' || TO_CHAR(v_current_balance, 'FM99999999.00'));
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Error: Account number ' || p_account_no || ' not found for final balance.');
    END;


    DBMS_OUTPUT.PUT_LINE('--- End of Statement ---');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle case where the initial account number for the statement is not found
        DBMS_OUTPUT.PUT_LINE('Error: Account number ' || p_account_no || ' not found.');
    WHEN OTHERS THEN
        -- Handle any other errors
        DBMS_OUTPUT.PUT_LINE('An error occurred during statement generation: ' || SQLERRM);
        -- Ensure the cursor is closed if an error occurs after opening
        IF account_statement_cur%ISOPEN THEN
            CLOSE account_statement_cur;
        END IF;
        RAISE; -- Re-raise the exception
END;
/




-- Create or replace a view that provides a comprehensive look at a customer's
-- accounts, transactions, and associated branch/bank information.
-- This view is intended to be queried by filtering on C_ID to show a specific customer's data.

CREATE OR REPLACE VIEW CUSTOMER_FULL_DETAILS_V AS
SELECT
    c.C_ID,
    c.Customerx AS Customer_Name,
    c.Address AS Customer_Address,
    c.Mobile_No AS Customer_Mobile,
    ba.Account_No,
    ba.Balance AS Account_Balance, -- Renamed to avoid confusion with transaction amount
    ba.Account_Type,
    b.Branch_code,
    b.Branch_name,
    b.Address AS Branch_Address,
    bk.B_Name AS Bank_Name,
    bk.City AS Bank_City,
    t.T_ID AS Transaction_ID, -- Transaction details start here
    t.T_Date AS Transaction_Date,
    t.Amount AS Transaction_Amount, -- Renamed to avoid confusion with account balance
    t.Modex AS Transaction_Mode,
    t.Status AS Transaction_Status,
    t.Card_No AS Transaction_Card_No, -- Card number used for the transaction
    card.Card_Type AS Transaction_Card_Type -- Type of card used for the transaction
FROM
    CUSTOMERX c
JOIN
    BANK_ACCOUNT ba ON c.C_ID = ba.C_ID -- A customer can have multiple accounts
JOIN
    BRANCH b ON ba.Branch_code = b.Branch_code -- Each account belongs to one branch
JOIN
    BANK bk ON b.B_Code = bk.B_Code -- Each branch belongs to one bank
LEFT JOIN
    TRANSACTION t ON ba.Account_No = t.Account_No -- An account can have multiple transactions (use LEFT JOIN to include accounts with no transactions)
LEFT JOIN
    CARD card ON t.Card_No = card.Card_No; -- A transaction might use a card (use LEFT JOIN to include transactions without a card)

-- Note: When querying this view for a specific customer, you would add a WHERE clause like:




SELECT * FROM CUSTOMER_FULL_DETAILS_V WHERE C_ID = 'CUST01';



-- 1. Find all customers living in a specific city:
SELECT C_ID, Customerx, Mobile_No
FROM CUSTOMERX
WHERE Address LIKE '%Patiala%'; 

-- 2. List all branches of a specific bank:
SELECT b.Branch_name, b.Address
FROM BRANCH b
JOIN BANK bk ON b.B_Code = bk.B_Code
WHERE bk.B_Name = 'State Bank'; 

-- 3. Get the details of a specific employee:
SELECT E_Name, Position, Salary, Hire_Date
FROM EMPLOYEE
WHERE E_ID = 'EMP001'; 

-- 4. Find all accounts belonging to a specific customer:
SELECT Account_No, Balance, Account_Type
FROM BANK_ACCOUNT
WHERE C_ID = 'CUST01'; 

-- 5. List all loans availed by a specific customer:
SELECT Loan_No, Amount, Interest_Rate
FROM LOANS
WHERE C_ID = 'CUST01'; 

-- 6. Get all transactions for a specific account:
SELECT T_ID, T_Date, Amount, Modex, Status
FROM TRANSACTION
WHERE Account_No = 'ACC1001'
ORDER BY T_Date DESC;

-- 7. Find all cards issued to a specific customer:
SELECT Card_No, Card_Type
FROM CARD
WHERE C_ID = 'CUST01'; 

-- 8. Get all payments made for a specific loan:
SELECT P_Account, P_Date, Amount
FROM PAYMENT
WHERE Loan_No = 'LN2001'
ORDER BY P_Date;

-- Queries using the CUSTOMER_FULL_DETAILS_V View:
-- The CUSTOMER_FULL_DETAILS_V view is designed to simplify queries that combine information from multiple tables for a customer.

-- 9. Get all details (accounts, transactions, branch, bank) for a specific customer:
SELECT *
FROM CUSTOMER_FULL_DETAILS_V
WHERE C_ID = 'CUST01'; -- Replace 'CUST001' with the desired customer ID

-- 10. List all transactions for a specific customer's accounts within a date range:
SELECT
    Customer_Name,
    Account_No,
    Transaction_ID,
    Transaction_Date,
    Transaction_Amount,
    Transaction_Mode,
    Transaction_Status
FROM
    CUSTOMER_FULL_DETAILS_V
WHERE
    C_ID = 'CUST01' 
    AND Transaction_Date BETWEEN TO_DATE('2025-05-01', 'YYYY-MM-DD') AND TO_DATE('2025-05-31', 'YYYY-MM-DD')
ORDER BY
    Transaction_Date, Transaction_ID;

-- 11. Find the total balance across all accounts for a specific customer:
SELECT
    Customer_Name,
    SUM(Account_Balance) AS Total_Balance
FROM
    CUSTOMER_FULL_DETAILS_V
WHERE
    C_ID = 'CUST001' -- Replace 'CUST001'
GROUP BY
    C_ID, Customer_Name;
-- Note: This query assumes you want the sum of the current balances of their accounts. The view includes transaction amounts separately.

-- 12. List all transactions made by a specific customer using a 'Debit Card':
SELECT
    Customer_Name,
    Account_No,
    Transaction_ID,
    Transaction_Date,
    Transaction_Amount,
    Transaction_Mode
FROM
    CUSTOMER_FULL_DETAILS_V
WHERE
    C_ID = 'CUST001' -- Replace 'CUST001'
    AND Transaction_Card_Type = 'Debit Card';

-- 13. Find customers who have accounts at a specific branch:
SELECT DISTINCT
    C_ID,
    Customer_Name
FROM
    CUSTOMER_FULL_DETAILS_V
WHERE
    Branch_code = 'BR001'; -- Replace 'BR001' with the desired branch code
-- Note: Using DISTINCT here is important because a customer might appear multiple times in the view if they have multiple accounts at that branch.

-- Aggregate Queries:

-- 14. Calculate the total balance held in a specific branch:
SELECT SUM(Balance) AS Total_Branch_Balance
FROM BANK_ACCOUNT
WHERE Branch_code = 'BR001'; -- Replace 'BR001'

-- 15. Find the average loan amount:
SELECT AVG(Amount) AS Average_Loan_Amount
FROM LOANS;

-- 16. Count the number of customers in each city:
SELECT City, COUNT(*) AS Number_of_Customers
FROM CUSTOMERX
GROUP BY City;

-- 17. Find the total salary expenditure for each branch:
SELECT b.Branch_name, SUM(e.Salary) AS Total_Salary
FROM EMPLOYEE e
JOIN BRANCH b ON e.Branch_code = b.Branch_code
GROUP BY b.Branch_name;
