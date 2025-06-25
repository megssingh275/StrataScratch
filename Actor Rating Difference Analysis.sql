/*

HARD

Actor Rating Difference Analysis

You are given a dataset of actors and the films they have been involved in, including each film's release date and rating. For each actor, calculate the difference between the rating of their most recent film and their average rating across all previous films (the average rating excludes the most recent one).


Return a list of actors along with their average lifetime rating, the rating of their most recent film, and the difference between the two ratings. If an actor has only one film, return 0 for the difference and their only film’s rating for both the average and latest rating fields.

Table
actor_rating_shift
*/
with actor_list as (
select *,
rank() over(partition by actor_name order by release_date desc) rnk
from actor_rating_shift),

first_act as (
select actor_name, film_rating
from actor_list 
where rnk = 1
),

sec_list as (
select actor_name, avg(film_rating) as avg_sec 
from actor_list 
where rnk != 1
group by 1
)

select a.actor_name, a.film_rating, ifnull(s.avg_sec,film_rating) as latest_rating, ifnull((a.film_rating - s.avg_sec),0) as rating_difference
from first_act a left join sec_list s
on a.actor_name = s.actor_name