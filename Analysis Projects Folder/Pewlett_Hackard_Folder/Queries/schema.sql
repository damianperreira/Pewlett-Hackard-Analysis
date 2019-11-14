CREATE TABLE public.departments
(
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    dept_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT departments_pkey PRIMARY KEY (dept_no),
    CONSTRAINT departments_dept_name_key UNIQUE (dept_name)

);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);


CREATE TABLE DEPT_EMP (
	EMP_NO INT NOT NULL,
	DEPT_NO VARCHAR NOT NULL,
	FROM_DATE DATE,
	TO_DATE DATE,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (DEPT_NO) REFERENCES DEPARTMENTS (DEPT_NO)
);


CREATE TABLE public.employees --generated ql using PgAdmin
(
    emp_no integer NOT NULL,
    birth_date date NOT NULL,
    first_name character varying COLLATE pg_catalog."default" NOT NULL,
    last_name character varying COLLATE pg_catalog."default" NOT NULL,
    gender character varying COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    CONSTRAINT employees_pkey PRIMARY KEY (emp_no)
)

CREATE TABLE public.managers --generated ql using PgAdmin
(
    dept_no character varying(4) COLLATE pg_catalog."default" NOT NULL,
    emp_no integer NOT NULL,
    from_date date NOT NULL,
    to_date date NOT NULL,
    CONSTRAINT dept_manager_pkey PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT dept_manager_dept_no_fkey FOREIGN KEY (dept_no)
        REFERENCES public.departments (dept_no) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT dept_manager_emp_no_fkey FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE
)

CREATE TABLE public.titles --generated ql using PgAdmin
(
    emp_no integer NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    from_date date,
    to_date date,
    CONSTRAINT titles_pkey PRIMARY KEY (emp_no),
    CONSTRAINT titles_emp_no_fkey FOREIGN KEY (emp_no)
        REFERENCES public.employees (emp_no) MATCH SIMPLE