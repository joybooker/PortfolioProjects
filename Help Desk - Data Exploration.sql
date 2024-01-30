/* Help Desk Data Exploration */

-- Total Tickets

SELECT COUNT(ticket_number) AS TotalTickets
FROM HelpDesk

-- Number of Tickets by Severity

SELECT severity, COUNT(severity) AS TotalTicketsBySeverity
FROM HelpDesk
GROUP BY severity

-- Number of Tickets by Type

SELECT ticket_type, COUNT(ticket_type) AS TotalTicketTypes
FROM HelpDesk
GROUP BY ticket_type

-- Number of Tickets by Status
SELECT ticket_status, COUNT(ticket_status) AS TotalTicketsByStatus
FROM HelpDesk
GROUP BY ticket_status

-- Number of Tickets by Issue Category
SELECT issue_category, COUNT(issue_category) AS TotalTicketsByCategory
FROM HelpDesk
GROUP BY issue_category

-- Number of Tickets by Owner Group

SELECT owner_group, COUNT(owner_group) AS TotalTicketsByCategory
FROM HelpDesk
GROUP BY owner_group

-- High Severity Tickets - Open vs. Resolved

-- (1)

SELECT Count (severity) AS High_Open_Tickets
FROM HelpDesk
WHERE severity = '3 - High' AND ticket_status = 'Open'

-- (2)

SELECT Count (severity) AS High_Resolved_Tickets
FROM HelpDesk
WHERE severity = '3 - High' AND ticket_status = 'Resolved'

-- Highest Amount of Time A Ticket Stayed Open

SELECT MAX(days_open) AS MaxDaysOpen
FROM HelpDesk

-- Percentage of Customers Highly Satisfied

SELECT COUNT (satisfaction_score)/100 AS PercentHighlySatisfied
FROM HelpDesk
WHERE satisfaction_score = '3 - Highly Satisfied'

-- Percentage of Customers Satisfied

SELECT COUNT (satisfaction_score)/100 AS PercentSatisfied
FROM HelpDesk
WHERE satisfaction_score = '2 - Satisfied'

-- Percentage of Customers Unsatisfied

SELECT COUNT (satisfaction_score)/100 AS PercentUnsatisfied
FROM HelpDesk
WHERE satisfaction_score = '1 - Unsatisfied'

-- Total Tickets per Month

SELECT DATENAME(Month, created_date) as Order_Month, COUNT(DISTINCT ticket_number) AS Total_Tickets
FROM HelpDesk
GROUP BY DATENAME(Month, created_date)
ORDER BY Total_Tickets DESC