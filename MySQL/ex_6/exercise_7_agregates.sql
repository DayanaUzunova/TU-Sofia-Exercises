#sum without null
Select count(coach_id) from sportGroups;
#sum with null
Select count(*) from sportGroups; 

Select group_id, sum(paymentAmount)
from taxesPayments
#групираме по група,агрегатна функция върху отделни части
#и тук слагаме други ограничаващи условия, които не зависят от агрегатната функция
group by group_id
#условие за агрегатна функция
having sum(paymentAmount)>11000;

