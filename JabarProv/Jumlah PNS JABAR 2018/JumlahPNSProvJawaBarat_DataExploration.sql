
SELECT *
FROM jabarprov..JmlhPNS

-- Total jumlah PNS

SELECT SUM(jumlah_pns) AS TotalPNS
FROM jabarprov..JmlhPNS

-- Total unit kerja

SELECT COUNT(DISTINCT(unit_kerja)) AS TotalUnitKerja
FROM jabarprov..JmlhPNS

-- Total golongan

SELECT COUNT(DISTINCT(golongan)) AS TotalGolongan
FROM jabarprov..JmlhPNS

-- Total jumlah PNS berdasarkan unit kerja

SELECT unit_kerja
, SUM(jumlah_pns) AS TotalPNSPerUnitKerja
FROM jabarprov..JmlhPNS
GROUP BY unit_kerja

-- Persentase jumlah PNS berdasarkan unit kerja

CREATE TABLE #unitkerja (
TotalPNS numeric,
unit_keja nvarchar(255),
TotalPNSPerUnitKerja numeric
)

INSERT INTO #unitkerja
SELECT (SELECT SUM(jumlah_pns) FROM jabarprov..JmlhPNS) AS TotalPNS
, unit_kerja
, SUM(jumlah_pns) AS TotalPNSPerUnitKerja
FROM jabarprov..JmlhPNS
GROUP BY unit_kerja

SELECT *
, (TotalPNSPerUnitKerja/TotalPNS) AS PersentasePerUnitKerja
FROM #unitkerja

-- Total jumlah PNS per golongan

SELECT golongan
, SUM(jumlah_pns) AS TotalPNSPPerGolongan
FROM jabarprov..JmlhPNS
GROUP BY golongan

-- Persentase PNS per golongan

CREATE TABLE #pns_golongan (
TotalPNS numeric,
golongan nvarchar (50),
TotalPNSPerGolongan numeric
)

INSERT INTO #pns_golongan
SELECT (SELECT SUM(jumlah_pns) FROM jabarprov..JmlhPNS) AS TotalPNS
, golongan
, SUM(jumlah_pns) AS TotalPNSPerGolongan
FROM jabarprov..JmlhPNS
GROUP BY golongan

SELECT *
, (TotalPNSPerGolongan/TotalPNS) AS PersentasePerGolongan
FROM #pns_golongan