/*

Hard
Player with Longest Streak
You are given a table of tennis players and their matches that they could either win (W) or lose (L). Find the longest streak of wins. A streak is a set of consecutive won matches of one player. The streak ends once a player loses their next match. Output the ID of the player or players and the length of the streak.

Table
players_results
*/

WITH StreakGroups AS (
    SELECT 
        player_id,
        match_result,
        SUM(CASE WHEN match_result = 'L' THEN 1 ELSE 0 END) 
            OVER (PARTITION BY player_id ORDER BY match_date) AS streak_group
    FROM 
        players_results
),
StreakLengths AS (
    SELECT 
        player_id,
        COUNT(*) AS streak
    FROM 
        StreakGroups
    WHERE 
        match_result = 'W'
    GROUP BY 
        player_id, streak_group
)
SELECT 
    player_id,
    MAX(streak) AS streak
FROM 
    StreakLengths
GROUP BY 
    player_id
HAVING 
    MAX(streak) = (SELECT MAX(streak) FROM StreakLengths)
ORDER BY 
    player_id;