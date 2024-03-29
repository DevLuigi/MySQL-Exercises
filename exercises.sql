use sakila;

/* mySQL exercises - SAKILA */
/* url: https://github.com/NederlandsMD/SQL--Sakila_DB-Exercises/blob/master/Instructions.md */

/* 1a. You need a list of all the actors. Display the first and last names of all actors from the table actor. */
Select
	first_name,
    last_name
from
	actor;
    
/* 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name. */
Select
	concat(upper(first_name), ' ', upper(last_name)) as 'Actor Name'
from
	actor;
    
/* 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe". What is one query would you use to obtain this information? */
Select
	actor_id,
    first_name,
    last_name
from
	actor
where
	first_name like 'Joe';

/* 2b. Find all actors whose last name contain the letters GEN: */
Select
	*
from 
	actor
where
	last_name like '%GEN%';
    
/* 2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order: */
Select
	*
from
	actor
where
	last_name like '%LI%' 
order by
	last_name,
    first_name;
    
/* 2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China: */
Select
	*
from
	country
where
	country in ('Afghanistan', 'Bangladesh', 'China');
    
/* 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type. */
Alter table actor
Add column middle_name varchar(45) after first_name;

/* 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs. */
Alter table actor
Modify middle_name blob;

/* 3c. Now delete the middle_name column. */
Alter table actor
Drop column middle_name;

/* 4a. List the last names of actors, as well as how many actors have that last name. */
Select
	last_name,
    count(last_name) 'quantity'
from
	actor
group by
	last_name;
    
/* 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors */
Select
	last_name,
    count(last_name) 'quantity'
from
	actor
group by
	last_name
having 
	quantity > 2;
    
/* 4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record. */
-- update actor set
update actor set
	first_name = 'HARPO' 
where 
	first_name like 'GROUCHO' and 
    last_name like 'WILLIAMS';

/* 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.) */
update actor set
	 first_name = 	Case 
						When first_name = 'HARPO' Then 'GROUCHO'
						Else 'MUCHO GROUCHO'
					End
where
	actor_id = 172;
	