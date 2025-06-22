-- CREATE DATABASE
Create database contact_center_analysis;
use contact_center_analysis;


-- TABLE: agent_performance
CREATE TABLE agent_performance (
    agent_id INT PRIMARY KEY,
    agent_name VARCHAR(100),
    department VARCHAR(50),
    hire_date DATE,
    total_calls_handled INT,
    average_call_duration_sec FLOAT,
    customer_rating_avg FLOAT);


-- TABLE: call_logs
 CREATE TABLE call_logs (
    call_id INT PRIMARY KEY,
    customer_id INT,
    agent_id INT,
    call_date_time DATETIME,
    call_duration_sec INT,
    issue_category VARCHAR(50),
    call_status VARCHAR(20),
    resolution_status VARCHAR(20),
    first_call_resolution BOOLEAN);


-- TABLE: customer_feedback
 CREATE TABLE customer_feedback (
    feedback_id INT PRIMARY KEY,
    call_id INT,
    customer_id INT,
    feedback_text TEXT,
    customer_rating INT);


-- TABLE: issue_escalation
CREATE TABLE issue_escalation (
    escalation_id INT PRIMARY KEY,
    call_id INT,
    escalation_reason VARCHAR(100),
    escalated_to VARCHAR(50),
    escalation_date DATETIME);
