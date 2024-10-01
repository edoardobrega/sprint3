-- SPRINT 3

-- 1.1
CREATE INDEX idx_credit_card ON transaction(credit_card_id);
CREATE TABLE credit_card (
        id VARCHAR(100) NOT NULL PRIMARY KEY,
        iban VARCHAR(100),
        pan VARCHAR(100),
        pin int,
        cvv int,
        expiring_date VARCHAR(100),
        FOREIGN KEY(id) REFERENCES transaction(credit_card_id)        
    );

-- 1.2
update credit_card set iban = 'R323456312213576817699999'
where id = 'CcU-2938';

-- 1.3
INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined) 
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '999', '829.999', '-117.999', '111.11', '0');

-- 1.4
ALTER TABLE credit_card DROP pan;

-- 2.1
DELETE FROM transaction WHERE id='02C6201E-D90A-1859-B4EE-88D2986D3B02';

-- 2.2
CREATE VIEW VistaMarketing AS
SELECT company_name'Nom de la companyia',phone'Telèfon de contacte',
country'País de residència',ROUND( AVG(amount),2)'Mitjana de compra'
FROM company
join transaction on transaction.company_id = company.id
where declined = 0
group by company_id
order by avg(amount) desc;

-- 2.3
SELECT `Nom de la companyia` FROM transactions.vistamarketing
where `País de residència`='germany';

-- 3.1
SET FOREIGN_KEY_CHECKS=0;
alter table company drop website;
alter table user rename data_user;
alter table data_user rename column email to personal_email;
alter table credit_card modify id VARCHAR(20);
alter table credit_card modify iban VARCHAR(50);
alter table credit_card modify pin VARCHAR(4);
alter table credit_card modify expiring_date VARCHAR(10);
alter table credit_card add column fecha_actual date;

-- 3.2
CREATE VIEW InformeTecnico AS
SELECT transaction.id 'ID de la transacció',data_user.name'Nom de l´usuari/ària',
data_user.surname'Cognom de l`usuari/ària',credit_card.iban'IBAN de la targeta de crèdit usada',company.company_name'Nom de la companyia de la transacció realitzada'
FROM transaction
join data_user on data_user.id=transaction.user_id
join credit_card on credit_card.id=transaction.credit_card_id
join company on transaction.company_id = company.id
-- where declined = 0
order by transaction.id desc;
