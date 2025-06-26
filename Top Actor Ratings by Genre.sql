/*

Hard

Top Actor Ratings by Genre

Find the top actors based on their average movie rating within the genre they appear in most frequently.
•  For each actor, determine their most frequent genre (i.e., the one they’ve appeared in the most).
•   If there is a tie in genre count, select the genre where the actor has the highest average rating.
•   If there is still a tie in both count and rating, include all tied genres for that actor.


Rank the resulting actor + genre pairs by their average rating in descending order.
•  Return all actor + genre pairs that fall within the top 3 ranks (not rows), including ties.
•  Do not skip ranks — for example, if multiple actors are tied at rank 1, the next rank is 2.

Table
top_actors_rating
*/

select actor_name,genre,avg_rating from(select *, dense_rank()over(order by avg_rating desc) as drk from (
select distinct actor_name,genre, count(*) as freq ,avg(movie_rating) as avg_rating, rank()over(partition by actor_name order by count(*) desc,avg(movie_rating) desc) as rk 
from top_actors_rating
group by 1,2
order by 3 desc, 4 desc) a
where rk=1
order by 3 desc) b
where drk in (1,2,3)
order by 3 desc