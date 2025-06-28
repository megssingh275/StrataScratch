/*
Hard

Reviewed flags of top videos

For the video (or videos) that received the most user flags, how many of these flags were reviewed by YouTube? Output the video ID and the corresponding number of reviewed flags.

Tables
user_flags
flag_review
*/


with t as (
    select 
        t1.video_id,
        rank() over(order by count(t1.flag_id) desc) as flags_cnt_rank, 
        sum(coalesce(reviewed_by_yt, 0)) yt_cnt
    from user_flags t1
    join flag_review t2
        on t1.flag_id = t2.flag_id
    group by t1.video_id
)

select video_id, yt_cnt from t where flags_cnt_rank = 1
