SELECT *
FROM PortfolioProject..DataMinum

-- Hitung jumlah orang per kategori

SELECT Kategori
, COUNT(Kategori) JumlahOrgPerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori

-- Persentase per kategori

CREATE TABLE #temp_minum (
JumlahOrg numeric,
Kategori nvarchar(50),
JumlahOrgPerKategori numeric
)

INSERT INTO #temp_minum
SELECT (SELECT COUNT(Nama) FROM PortfolioProject..DataMinum) AS JumlahOrg
, Kategori
, COUNT(Kategori) AS JumlahOrgPerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori

SELECT *
, (JumlahOrgPerKategori/Jumlahorg)*100 AS PersentaseOrgPerKategori
FROM #temp_minum

-- Rata-rata usia per kategori

SELECT Kategori
, AVG(Usia) AS RataRataUsiaPerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori

-- Rata-rata berat per kategori

SELECT Kategori
, AVG(Berat) AS RataRataBeratPerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori

-- Rata-rata tinggi per kategori

SELECT Kategori
, AVG(Tinggi) AS RataRataTinggiPerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori

-- Rata-rata income per kategori

SELECT Kategori
, AVG(Income) AS RataRataIncomePerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori

-- Rata-rata jam kerja per kategori

SELECT Kategori
, AVG(JamKerja) AS RataRataJamKerjaPerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori

-- Rata-rata olahraga per kategori

SELECT Kategori
, AVG(Olahraga) AS RataRataOlahragaPerKategori
FROM PortfolioProject..DataMinum
GROUP BY Kategori