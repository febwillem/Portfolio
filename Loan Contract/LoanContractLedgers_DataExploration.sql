
SELECT *
FROM PortfolioProject..loan_contract_ledgers

-- Count ledger for each contract

SELECT contract_id
, COUNT(ledger_id) AS CountLedger
FROM PortfolioProject..loan_contract_ledgers
GROUP BY contract_id

-- First ledger for each contract

SELECT contract_id
, ledger_id
, created_at
FROM PortfolioProject..loan_contract_ledgers
WHERE created_at IN 
	(SELECT MIN(created_at)
	FROM PortfolioProject..loan_contract_ledgers l
	GROUP BY l.contract_id)
ORDER BY contract_id

-- Number of each ledger type

SELECT ledger_type
, COUNT(ledger_type) AS NumberLedgerType
FROM
PortfolioProject..loan_contract_ledgers
GROUP BY ledger_type

-- Percentage of each ledger type

DROP TABLE IF EXISTS #LedgerType
CREATE TABLE #LedgerType (
AmountOfLedger numeric,
ledger_type nvarchar(50),
AmountOfLedgerType numeric
)

INSERT INTO #LedgerType
SELECT (SELECT COUNT(ledger_id) FROM PortfolioProject..loan_contract_ledgers) AS AmountOfLedger
, ledger_type
, COUNT(ledger_type) AS AmountOfLedgerType
FROM PortfolioProject..loan_contract_ledgers
GROUP BY ledger_type

SELECT *
, (AmountOfLedgerType/AmountOfLedger)*100 AS PercentOfLedgerType
FROM #LedgerType

-- Number of each ledger status

SELECT ledger_status
, COUNT(ledger_status)
FROM PortfolioProject..loan_contract_ledgers
GROUP BY ledger_status

-- Percentage of each ledger status

DROP TABLE IF EXISTS #LedgerStatus
CREATE TABLE #LedgerStatus (
AmountOfLedger numeric,
ledger_status nvarchar(50),
AmountOfLedgerStatus numeric
)

INSERT INTO #LedgerStatus
SELECT (SELECT COUNT(ledger_id) FROM PortfolioProject..loan_contract_ledgers) AS AmountOfLedger
, ledger_status
, COUNT(ledger_status) AS AmountOfLedgertStatus
FROM PortfolioProject..loan_contract_ledgers
GROUP BY ledger_status

SELECT *
, (AmountOfLedgerStatus/AmountOfLedger)*100 AS PercentLedgerStatus
FROM #LedgerStatus

-- Lowest initial balance that are not 0

SELECT ledger_id
,contract_id
, initial_balance
FROM PortfolioProject..loan_contract_ledgers
WHERE initial_balance IN (
	SELECT MIN(initial_balance)
	FROM PortfolioProject..loan_contract_ledgers
	WHERE initial_balance > 0)

-- Highest initial balance

SELECT ledger_id
,contract_id
, initial_balance
FROM PortfolioProject..loan_contract_ledgers
WHERE initial_balance IN (
	SELECT MAX(initial_balance)
	FROM PortfolioProject..loan_contract_ledgers)

-- Sum balance of each contract id

SELECT contract_id
, SUM(balance) AS TotalBalance
FROM PortfolioProject..loan_contract_ledgers
GROUP BY contract_id

-- Count ledger type of each contract id

SELECT contract_id
, ledger_type
, COUNT(ledger_type) AS AmountOfLedgerType
FROM PortfolioProject..loan_contract_ledgers
GROUP BY contract_id, ledger_type
ORDER BY contract_id


-- Count ledger that has been waived for each contract id

SELECT contract_id
, ledger_type
, COUNT(ledger_type) AS AmountOfLedgerType
, ledger_status
FROM PortfolioProject..loan_contract_ledgers
WHERE ledger_status = 'WAIVED'
GROUP BY contract_id, ledger_type, ledger_status
ORDER BY contract_id

-- Count ledger status of each contract id

SELECT contract_id
, ledger_status
, COUNT(ledger_status) AS AmountOfLedgerStatus
FROM PortfolioProject..loan_contract_ledgers
GROUP BY contract_id, ledger_status
ORDER BY contract_id