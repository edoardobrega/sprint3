-- SPRINT 3

-- 1.1

CREATE TABLE company ( 
    id VARCHAR(15) PRIMARY KEY, 
    company_name VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100),
    country VARCHAR(100),
    website VARCHAR(255));

CREATE TABLE transaction ( 
    id VARCHAR(255) PRIMARY KEY, 
    credit_card_id VARCHAR(15), 
    company_id VARCHAR(20),
    user_id INT,
    lat FLOAT,
    longitude FLOAT,
    timestamp TIMESTAMP,
    amount DECIMAL(10, 2),
    declined BOOLEAN);

CREATE TABLE user ( 
    id INT PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    phone VARCHAR(150),
    email VARCHAR(150),
    birth_date VARCHAR(100),
    country VARCHAR(150),
    city VARCHAR(150),
    postal_code VARCHAR(100),
    address VARCHAR(255));

CREATE TABLE credit_card ( 
    id VARCHAR(20) PRIMARY KEY, 
    iban VARCHAR(50),
    pan VARCHAR(100),
    pin VARCHAR (4),
    cvv int,
    expiring_date VARCHAR(10));

CREATE INDEX idx_transaction_user_id ON transaction(user_id);
CREATE INDEX idx_transaction_company_id ON transaction(company_id);
CREATE INDEX idx_transaction_credit_card_id ON transaction(credit_card_id);
CREATE INDEX idx_transaction_timestamp ON transaction(timestamp);
CREATE INDEX idx_transaction_declined ON transaction(declined);

ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_company FOREIGN KEY (company_id) REFERENCES company(id),

ADD CONSTRAINT fk_transaction_user FOREIGN KEY (user_id) REFERENCES user(id),

ADD CONSTRAINT fk_transaction_credit_card FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);

update credit_card
set expiring_date = str_to_date(expiring_date, '%m/%d/%Y');


-- 1.2
update credit_card set iban = 'R323456312213576817699999'
where id = 'CcU-2938';

-- 1.3
INSERT INTO user (id) VALUES ('999');INSERT INTO credit_card (id) VALUES ('CcU-9999');INSERT INTO company (id) VALUES ('b-9999');

INSERT INTO transaction (id,credit_card_id, company_id, user_id, lat, longitude, timestamp,amount, declined) VALUES 
( '108B1D1D-5B23-A76C-55EF-C568E49A99DD','CcU-9999', 'b-9999', '999', '829.999', '-117.999', null , '111.11', '0');

-- 1.4
ALTER TABLE credit_card DROP pan;

-- 2.1
DELETE FROM transaction WHERE id='02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- 2.2
CREATE VIEW VistaMarketing AS
SELECT company_name'Nom companyia',phone'Telèfon',
country'País',ROUND( AVG(amount),2)'Mitjana compra'
FROM company
join transaction on company_id = company.id
where declined = 0
group by company_id
order by 'Mitjana compra' desc;
select*from VistaMarketing;

-- 2.3
SELECT `Nom de la companyia` FROM transactions.vistamarketing
where `País de residència`='germany';

-- 3.1
alter table company drop website;
alter table user rename data_user;
alter table data_user rename column email to personal_email;
alter table credit_card add column fecha_actual date;

-- 3.2
CREATE VIEW InformeTecnico AS
SELECT transaction.id 'ID transacció',data_user.name'Nom',data_user.surname'Cognom',credit_card.iban'IBAN',company.company_name'Companyia'
FROM transaction
join data_user on data_user.id=transaction.user_id
join credit_card on credit_card.id=transaction.credit_card_id
join company on transaction.company_id = company.id
order by transaction.id desc;

