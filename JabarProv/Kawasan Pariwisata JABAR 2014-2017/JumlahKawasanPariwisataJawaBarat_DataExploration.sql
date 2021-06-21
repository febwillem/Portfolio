
SELECT *
FROM jabarprov..JmlhPariwisata

-- Jumlah Kab/Kota JaBar

SELECT COUNT(DISTINCT(nama_kabupaten_kota)) AS TotalKabKota
FROM jabarprov..JmlhPariwisata

-- Total jumlah kawasan pariwisata JaBar

SELECT SUM(jumlah_kawasan) AS TotalKawasan
FROM jabarprov..JmlhPariwisata

-- Jumlah kawasan per tahun

SELECT tahun
, SUM(jumlah_kawasan) AS TotalKawasanPerTahun
FROM jabarprov..JmlhPariwisata
GROUP BY tahun

-- Jumlah kawasan per Kab/Kota

SELECT nama_kabupaten_kota
, SUM(jumlah_kawasan) AS TotalKawasanPerKabKota
FROM jabarprov..JmlhPariwisata
GROUP BY nama_kabupaten_kota

-- Persentase jumlah kawasan per Kab/Kota

CREATE TABLE #KawasanPerKabKota (
TotalKawasan numeric,
nama_kabupaten_kota nvarchar(255),
TotalKawasanPerKabKota numeric
)

INSERT INTO #KawasanPerKabKota
SELECT (SELECT SUM(jumlah_kawasan) FROM jabarprov..JmlhPariwisata) AS TotalKawasan
, nama_kabupaten_kota
, SUM(jumlah_kawasan) AS TotalKawasanPerKabkota
FROM jabarprov..JmlhPariwisata
GROUP BY nama_kabupaten_kota

SELECT *
, (TotalKawasanPerKabKota/TotalKawasan) AS PersentaseKawasanPerKabKota
FROM #KawasanPerKabKota