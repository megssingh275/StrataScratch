/*
HARD

Marketing Campaign Success [Advanced]

You have the marketing_campaign table, which records in-app purchases by users. Users making their first in-app purchase 
enter a marketing campaign, where they see call-to-actions for more purchases. Find how many users made additional purchases 
due to the campaign's success.


The campaign starts one day after the first purchase. Users with only one or multiple purchases on the first day do not count,
 nor do users who later buy only the same products from their first day.


*/

WITH first_purchase AS
  (SELECT user_id,
          MIN(created_at) AS first_order
   FROM marketing_campaign
   GROUP BY user_id),
     valid_users AS
  (SELECT user_id
   FROM marketing_campaign
   GROUP BY user_id
   HAVING COUNT(DISTINCT created_at) > 1
   AND COUNT(DISTINCT product_id) > 1),
     first_products AS
  (SELECT mc.user_id,
          mc.product_id
   FROM marketing_campaign mc
   INNER JOIN first_purchase fp ON mc.user_id = fp.user_id
   AND mc.created_at = fp.first_order)
SELECT COUNT(DISTINCT mc.user_id) AS user_count
FROM marketing_campaign mc
JOIN valid_users vu ON mc.user_id = vu.user_id
LEFT JOIN first_products fp ON mc.user_id = fp.user_id
AND mc.product_id = fp.product_id
WHERE fp.product_id IS NULL
