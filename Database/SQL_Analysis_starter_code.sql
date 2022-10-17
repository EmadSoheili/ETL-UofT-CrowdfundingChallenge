-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT
	cf_id,
	backers_count
FROM
	campaign
WHERE
	outcome = 'live'
GROUP BY
	cf_id
ORDER BY
	backers_count DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT
	cf_id,
	COUNT(backer_id)
FROM
	backers
GROUP BY
	cf_id
ORDER BY
	COUNT(backer_id) DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT
	ct.first_name,
	ct.last_name,
	ct.email,
	cm.goal - cm.pledged AS "Remaining Goal Amount"
INTO
	email_contacts_remaining_goal_amount
FROM
	campaign AS cm
	LEFT JOIN
	contacts AS ct
	ON
	ct.contact_id = cm.contact_id
WHERE
	cm.outcome = 'live'
ORDER BY
	cm.goal - cm.pledged DESC;

-- Check the table

SELECT
	*
FROM
	email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT
	b.email,
	b.first_name,
	b.last_name,
	b.cf_id,
	cm.company_name,
	cm.description,
	cm.end_date,
	cm.goal - cm.pledged
INTO
	email_backers_remaining_goal_amount
FROM
	campaign AS cm
	LEFT JOIN
	backers AS b
	ON
	cm.cf_id = b.cf_id
WHERE
	cm.outcome = 'live'
ORDER BY
	b.last_name ASC,
	b.first_name ASC;

-- Check the table

SELECT
	*
FROM
	email_backers_remaining_goal_amount;
