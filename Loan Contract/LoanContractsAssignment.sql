
SELECT *
FROM PortfolioProject..loan_contract_ledgers

------------------------------------------------------------------------
-- Show the expected sum of interest and principal for Aug, Sep, and Oct

-- Aug

SELECT ledger_type
, SUM(balance) AS AugTotalBalance
FROM PortfolioProject..loan_contract_ledgers
WHERE due_date >= '2020-08-01' AND due_date < '2020-08-31'
	  AND ledger_type <> 'RESTRUCTURE_DOWN_PAYMENT' AND ledger_type <> 'LATE_FEE'
GROUP BY ledger_type

-- Sep

SELECT ledger_type
, SUM(balance) AS SepTotalBalance
FROM PortfolioProject..loan_contract_ledgers
WHERE due_date >= '2020-09-01' AND due_date < '2020-09-30'
	  AND ledger_type <> 'RESTRUCTURE_DOWN_PAYMENT' AND ledger_type <> 'LATE_FEE'
GROUP BY ledger_type

-- Oct

SELECT ledger_type
, SUM(balance) AS OctTotalBalance
FROM PortfolioProject..loan_contract_ledgers
WHERE due_date >= '2020-10-01' AND due_date < '2020-10-31'
	  AND ledger_type <> 'RESTRUCTURE_DOWN_PAYMENT' AND ledger_type <> 'LATE_FEE'
GROUP BY ledger_type

-- Combine to one table

SELECT ledger_type
, SUM(balance) AS total_balance
, MIN(due_date) AS month
FROM PortfolioProject..loan_contract_ledgers
WHERE due_date >= '2020-08-01' AND due_date < '2020-08-31'
	  AND ledger_type <> 'RESTRUCTURE_DOWN_PAYMENT' AND ledger_type <> 'LATE_FEE'
GROUP BY ledger_type
UNION
SELECT ledger_type
, SUM(balance) AS total_balance
, MIN(due_date) AS month
FROM PortfolioProject..loan_contract_ledgers
WHERE due_date >= '2020-09-01' AND due_date < '2020-09-30'
	  AND ledger_type <> 'RESTRUCTURE_DOWN_PAYMENT' AND ledger_type <> 'LATE_FEE'
GROUP BY ledger_type
UNION
SELECT ledger_type
, SUM(balance) AS total_balance
, MIN(due_date) AS month
FROM PortfolioProject..loan_contract_ledgers
WHERE due_date >= '2020-10-01' AND due_date < '2020-10-31'
	  AND ledger_type <> 'RESTRUCTURE_DOWN_PAYMENT' AND ledger_type <> 'LATE_FEE'
GROUP BY ledger_type


-------------------------------------------------
-- Display LATE_FEE amount which has been waived

SELECT ledger_type
, COUNT(ledger_type) AS 'LATE_FEE Amount (that has been waived)'
FROM PortfolioProject..loan_contract_ledgers
WHERE ledger_type = 'LATE_FEE' AND ledger_status = 'WAIVED'
GROUP BY ledger_type