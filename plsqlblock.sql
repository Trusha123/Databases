SET SERVEROUTPUT ON

DECLARE
	v_name VARCHAR2(200);
BEGIN
	SELECT first_name INTO v_name
	FROM employees
	WHERE employee_id = 100;
	dbms_output.put_line('FIRST NAME IS'|| v_name);

END;
/
	
DECLARE 
	v_sal NUMBER(12,2);
	v_empno NUmBER(5) NOT NULL :=11234;
	v_location VARCHAR2(15) :='New York';
	v_hiredate DATE;
	c_commission CONSTANT NUMBER :=800;
	v_isPassed BOOLEAN := FALSE;
	
BEGIN
	v_sal :=670000.00;
	v_empno:=65467;
	v_location:='Ahmedabad';
	v_hiredate:= '15-FEB-2021';
	v_isPassed := TRUE;
	--c_commission :=400;
	DBMS_OUTPUT.PUT_LINE('SALARY IS:' || v_sal);
	DBMS_OUTPUT.PUT_LINE('EMPID IS:' || v_empno);
	DBMS_OUTPUT.PUT_LINE('LOCATION IS:' || v_location);
	DBMS_OUTPUT.PUT_LINE('HIREDATE IS:' || v_hiredate);
	--DBMS_OUTPUT.PUT_LINE('Is Passed: ' || v_isPassed);
	DBMS_OUTPUT.PUT_LINE('COMMISSION IS:' || c_commission);
	
END;
/

*****bind Variables in plsql*****
VARIABLE b_name VARCHAR2(20);

BEGIN
	SELECT first_name into :b_name
	FROM employees 
	WHERE employee_id = 100;
END;
/
--we cannot user dopl statement for printitng as it is non-plsql 
PRINT b_name;

*****Nested PL/SQL Block****
--outer pl/sql block
DECLARE 
	v_no NUMBER;
BEGIN
	v_no :=10;
	--inner pl/sql block
	DECLARE
		v_no NUMBER;
	BEGIN
		v_no :=20;
		dbms_output.put_line('Inner variable :' || v_no);
		dbms_output.put_line('Outer variable :' || v_no);
	END;--end of the ineer pl/sql block	
dbms_output.put_line('Outer variable :' || v_no);
END; --end of outer block
/

****Block as Qualifier****
*****Nested PL/SQL Block****
BEGIN<<outer>>
DECLARE 
	v_no NUMBER;
BEGIN
	v_no :=10;
	--inner pl/sql block
	DECLARE
		v_no NUMBER;
	BEGIN
		v_no :=20;
		dbms_output.put_line('Inner variable :' || v_no);
		dbms_output.put_line('Outer variable :' || outer.v_no);
	END;--end of the inner pl/sql block	
dbms_output.put_line('Outer variable :' || outer.v_no);
END; --end of outer block
END outer;
/


***%type****

DECLARE 
	v_sal employees.salary%TYPE;
	v_empno employees.employee_id%TYPE NOT NULL :=11234;
	v_location locations.city%TYPE :='New York';
	v_hiredate employees.hire_date%TYPE;
	c_commission CONSTANT employees.commission_pct%TYPE :=800;
	
BEGIN
	DBMS_OUTPUT.PUT_LINE('SALARY IS:' || v_sal);
	DBMS_OUTPUT.PUT_LINE('EMPID IS:' || v_empno);
	DBMS_OUTPUT.PUT_LINE('LOCATION IS:' || v_location);
	DBMS_OUTPUT.PUT_LINE('HIREDATE IS:' || v_hiredate);
	DBMS_OUTPUT.PUT_LINE('COMMISSION IS:' || c_commission);
END;
/

**select into***
DECLARE 
	v_emp_id employees.employee_id%TYPE;
	v_first_name employees.first_name%TYPE;
	v_sal employees.salary%TYPE;
	v_dept_no employees.department_id%TYPE;
	
BEGIN
	select employee_id, first_name, salary, department_id into v_emp_id,v_first_name,v_sal,v_dept_no from employees 
	where employee_id=200;
	DBMS_OUTPUT.PUT_LINE('EmpID IS:' || v_emp_id);
	DBMS_OUTPUT.PUT_LINE('First name IS:' || v_first_name);
	DBMS_OUTPUT.PUT_LINE('Salary IS:' || v_sal);
	DBMS_OUTPUT.PUT_LINE('Department ID IS:' || v_dept_no);
	
END;
/

BEGIN
	insert into product (id,name,brand,price) values (3009,'Washing machine','LG',29000.00)
END;
/


DECLARE
	v_price_update product.price%TYPE:=200;
BEGIN
	update product
	set price=price+v_price_update
	where id =3001;
end;


DML in PL/SQL

DECLARE 
	v_price product.price%type :=&price;
	v_id product.id%type := &id;
BEGIN
	update product
	set price=price+v_price
	where id =v_id;	
END;
/

DECLARE 
	v_price product.price%type :=&price;
	v_id product.id%type := &id;
BEGIN
	delete from product where id= v_id;	
END;
/

declare
	v_voter_age NUMBER :=20;
BEGIN
	If v_voter_age > 18 THEN
		dbms_output.put_line('Eligible for voting');
	ELSE
		dbms_output.put_line('Not eligible gor voting');
	ENd IF;
END;
/

declare
	v_child_age NUMBER(2,1):= &age;
begin
	if v_child_age>=3 and v_child_age<4 then
		dbms_output.put_line('Admission to nursery');	
	elsif v_child_age>=4 and v_child_age<5 then
		dbms_output.put_line('Admissiom to jr.kg');
	else
		dbms_output.put_line('Not eligible');

end if;
/

****case expression******
DECLARE
	v_grade CHAR(1) := UPPER('&grade');
	v_appraisal VARCHAR2(20);
BEGIN 
	v_appraisal := CASE v_grade
	WHEN 'A' Then 'Excellent'
	WHEN 'B' Then 'Very Good'
	WHEN 'C' Then 'Good'
	ELSE 'No such grade'
END;
	dbms_output.put_line('Grade:' || v_grade);
	dbms_output.put_line('Appraisal:' || v_appraisal);
end;
/


******case statement******

DECLARE
	v_weekday VARCHAR2(20) := LOWER('&day');
BEGIN 
	CASE v_weekday
		WHEN 'monday' then
		dbms_output.put_line('Meeting');
		WHEN 'tuesday' then
		dbms_output.put_line('Meeting');
		WHEN 'wednesday' then
		dbms_output.put_line('Meeting');
		:
		ELSE
		dbms_output.put_line('Invalid choice');
	END CASE;
	
END;
/

*****LOOP***
DECLARE
	v_count NUMBER;
BEGIN
	v_count :=1;
	LOOP 
		dbms_output.put_line('counter is:' || v_count);
		--v_count := v_count+1;
		EXIT WHEN v_count>1;
	END LOOP;
END;


***WHILE****

DECLARE
	v_count NUMBER;
BEGIN
	v_count := 1;
	WHILE v_count<=5 LOOP
		dbms_output.put_line('counter is:' || v_count);
		v_count := v_count+1;
	END LOOP;
END;
/

******FORLOOP*****

BEGIN 
	FOR v_count IN 1..5 LOOP
		dbms_output.put_line('Counter is : ' || v_count);
	END LOOP;
	
	dbms_output.put_line('In reverse order');
	FOR v_count IN REVERSE 1..5 LOOP
		dbms_output.put_line('Counter is : ' || v_count);
	END LOOP;


END;
/

*****create procedure
--Procedure created with compilation errors
create or replace procedure update_price(p_id product.id%type,new_price number,p_price in out number) as 

begin
	update product 
	SET price = price+new_price
	where id = p_id;
	select price into p_price
	FROM product
	where id=p_id;

end;
/

exec update_price(3004,2000.00);

***PL/SQL Function***
create or replace function get_annual_salary(p_sal number)
return number
as
BEGIN
	return p_sal * 12;
	
END;
/
select employee_id , first_name, salary, get_annual_salary(salary) from employees;





