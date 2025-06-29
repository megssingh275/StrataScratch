/*
MEDIUM
Election Results
The election is conducted in a city and everyone can vote for one or more candidates, or choose not to vote at all. Each person has 1 vote so if they vote for multiple candidates, their vote gets equally split across these candidates. For example, if a person votes for 2 candidates, these candidates receive an equivalent of 0.5 vote each. Some voters have chosen not to vote, which explains the blank entries in the dataset.


Find out who got the most votes and won the election. Output the name of the candidate or multiple names in case of a tie.
To avoid issues with a floating-point error you can round the number of votes received by a candidate to 3 decimal places.

Table
voting_results
*/
WITH split_table AS (
  SELECT 
    voter, 
    1.0/COUNT(candidate) as split
  FROM voting_results
  GROUP BY voter
), 

candidate_split_sums AS (
  SELECT 
    a.candidate, 
    SUM(b.split) as total_split
  FROM voting_results a
  inner JOIN split_table b 
  ON a.voter = b.voter
  GROUP BY a.candidate
)

SELECT 
  candidate
FROM candidate_split_sums
ORDER BY total_split DESC
LIMIT 1