SELECT *
FROM PortfolioProject..loan_contracts

-- Contract that still active

SELECT contract_status
, COUNT(contract_status) AS 'Amount of Contract that still active'
FROM PortfolioProject..loan_contracts
WHERE contract_status = 'ACTIVE'
GROUP BY contract_status

-- Amount of each contract status

SELECT contract_status
, COUNT(contract_status) AS 'Amount of each Contract'
FROM PortfolioProject..loan_contracts
GROUP BY contract_status

-- Contract with highest loan

SELECT contract_id
, loan_amount
FROM PortfolioProject..loan_contracts
WHERE loan_amount IN 
	(SELECT MAX(loan_amount)
	FROM PortfolioProject..loan_contracts l)

SELECT contract_id
, loan_amount
FROM PortfolioProject..loan_contracts
ORDER BY loan_amount DESC

-- Contract with lowest loan

SELECT contract_id
, loan_amount
FROM PortfolioProject..loan_contracts
WHERE loan_amount IN 
	(SELECT MIN(loan_amount)
	FROM PortfolioProject..loan_contracts l)

SELECT contract_id
, loan_amount
FROM PortfolioProject..loan_contracts
ORDER BY loan_amount

-- Average loan

SELECT AVG(loan_amount) AS 'Average Loan'
FROM PortfolioProject..loan_contracts

-- Sum of loan for each contract status

SELECT contract_status
, COUNT(contract_status) AS 'Amount of each Contract'
, SUM(loan_amount) AS 'Total Loan'
FROM PortfolioProject..loan_contracts
GROUP BY contract_status

-- Highest provision

SELECT contract_id
, provision
FROM PortfolioProject..loan_contracts
WHERE provision IN
	(SELECT MAX(provision)
	FROM PortfolioProject..loan_contracts)

-- Lowest provision

SELECT contract_id
, provision
FROM PortfolioProject..loan_contracts
WHERE provision IN
	(SELECT MIN(provision)
	FROM PortfolioProject..loan_contracts)

-- Average provision

SELECT AVG(provision) AS 'Average Provision'
FROM PortfolioProject..loan_contracts

-- Highest Interest

SELECT contract_id
, interest
FROM PortfolioProject..loan_contracts
WHERE interest IN
	(SELECT MAX(interest)
	FROM PortfolioProject..loan_contracts)

-- Average Interest

SELECT AVG(interest) AS 'Average Interest'
FROM PortfolioProject..loan_contracts

-- Highest Principal

SELECT contract_id
, principal
FROM PortfolioProject..loan_contracts
WHERE principal IN
	(SELECT MAX(principal)
	FROM PortfolioProject..loan_contracts)

-- Percentage of the finished contract

DROP TABLE IF EXISTS loan_temp
CREATE TABLE loan_temp
(
amount numeric,
contract_status nvarchar(255),
amount_contract numeric
)

INSERT INTO loan_temp
SELECT (SELECT COUNT(contract_id) FROM PortfolioProject..loan_contracts) AS amount
, contract_status
, COUNT(contract_status) AS amount_contract
FROM PortfolioProject..loan_contracts
GROUP BY contract_status

SELECT *, amount_contract/amount AS 'Percentage of each contract'
FROM loan_temp