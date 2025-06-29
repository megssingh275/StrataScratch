/*
MEDIUM
User with Most Approved Flags
Which user flagged the most distinct videos that ended up approved by YouTube? Output, in one column, their full name or names in case of a tie. In the user's full name, include a space between the first and the last name.

Tables
user_flags
flag_review

*/
with cte as (
    select concat(ifnull(u.user_firstname, ''), ' ', ifnull(u.user_lastname, '')) as username,
           dense_rank() over (order by count(distinct u.video_id) desc) as rnk
    from user_flags u
    left join flag_review f on u.flag_id = f.flag_id
    where f.reviewed_outcome = 'APPROVED'
    group by u.user_firstname, u.user_lastname
)

select username
from cte
where rnk = 1