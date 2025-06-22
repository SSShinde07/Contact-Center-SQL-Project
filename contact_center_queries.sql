-- USE DATABASE
USE contact_center_analysis;

-- 1. Daily Call Volume Trend
SELECT 
    DATE(call_date_time) AS call_date,
    COUNT(*) AS total_calls
FROM call_logs
GROUP BY call_date
ORDER BY call_date;

-- 2. Agent Performance Ranking
SELECT 
    agent_name, 
    total_calls_handled, 
    average_call_duration_sec, 
    customer_rating_avg
FROM agent_performance
ORDER BY total_calls_handled DESC
LIMIT 10;

-- 3. First Call Resolution Rate
SELECT 
    COUNT(CASE WHEN first_call_resolution = 1 THEN 1 END) / COUNT(*) * 100 AS fcr_percentage
FROM call_logs;

-- 4. Peak Call Hours
SELECT 
    HOUR(call_date_time) AS hour_of_day,
    COUNT(*) AS call_count
FROM call_logs
GROUP BY hour_of_day
ORDER BY call_count DESC;

-- 5. Average Handling Time per Issue Category
SELECT 
    issue_category,
    AVG(call_duration_sec) AS avg_handling_time_sec
FROM call_logs
GROUP BY issue_category
ORDER BY avg_handling_time_sec DESC;

-- 6. Top 5 Escalation Reasons
SELECT 
    escalation_reason,
    COUNT(*) AS total_escalations
FROM issue_escalation
GROUP BY escalation_reason
ORDER BY total_escalations DESC
LIMIT 5;

-- 7. Feedback Rating Distribution
SELECT 
    customer_rating,
    COUNT(*) AS total_feedbacks
FROM customer_feedback
GROUP BY customer_rating
ORDER BY customer_rating DESC;

-- 8. Calls Joined with Agent Names and Issue Categories
SELECT 
    c.call_id, 
    a.agent_name, 
    c.issue_category, 
    c.call_duration_sec, 
    c.first_call_resolution
FROM call_logs c
JOIN agent_performance a ON c.agent_id = a.agent_id
ORDER BY c.call_date_time DESC
LIMIT 50;

-- 9. Average Customer Rating per Agent
SELECT 
    a.agent_name,
    AVG(f.customer_rating) AS avg_customer_rating
FROM customer_feedback f
JOIN call_logs c ON f.call_id = c.call_id
JOIN agent_performance a ON c.agent_id = a.agent_id
GROUP BY a.agent_name
ORDER BY avg_customer_rating DESC
LIMIT 10;

-- 10. View: Daily Top Agent Performance
CREATE VIEW daily_top_agents AS
SELECT 
    DATE(c.call_date_time) AS call_date,
    a.agent_name,
    COUNT(c.call_id) AS calls_handled
FROM call_logs c
JOIN agent_performance a ON c.agent_id = a.agent_id
GROUP BY call_date, a.agent_name
ORDER BY call_date, calls_handled DESC
LIMIT 10;

-- Check View
SELECT * FROM daily_top_agents;
