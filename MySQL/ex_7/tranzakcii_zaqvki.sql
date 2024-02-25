BEGIN;
UPDATE customer_accounts
set amount=amount - 50000
where id=3 and amount >= 50000;

UPDATE customer_accounts
set amount = amount + 50000
where id=1;
COMMIT; #ROLL BACK