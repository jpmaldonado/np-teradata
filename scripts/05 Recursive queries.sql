database tutorial;

create table rec_employee (
	emp integer,
	emp_name varchar(30),
	mgr integer
);

insert into rec_employee values(1,'tom',3);
insert into rec_employee values(2,'jim',1);
insert into rec_employee values(3,'will',0);
insert into rec_employee values(4,'marius',1);
insert into rec_employee values(5,'lucy',2);
insert into rec_employee values(6,'julia',3);

select * from tutorial.rec_employee


with recursive emp_hier(emp, emp_name, mgr, lev) as
(
	select emp, emp_name, mgr, 0
	from rec_employee
	union all
	select e.emp, e.emp_name, e.mgr, eh.lev+1
	from rec_employee e
	join emp_hier eh
	on e.mgr = eh.emp
)
select * from emp_hier;



with recursive emp_hier_txt(emp, emp_name, acc) as
(
	select emp, emp_name, ''
	from rec_employee
	where emp = 1
	union all
	select e.emp, e.emp_name, eh.acc||','||cast(4 as char)
	from rec_employee e
	join emp_hier_txt eh
	on e.mgr = eh.emp
	where e.emp = eh.emp + 1
)
select * 
from emp_hier_txt

select *
from rec_employee
order by emp
group by 1,2,3
;


