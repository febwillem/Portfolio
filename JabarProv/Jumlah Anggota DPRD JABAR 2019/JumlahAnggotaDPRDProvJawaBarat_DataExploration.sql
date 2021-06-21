
SELECT *
FROM jabarprov..AnggotaDPRD

-- Total jumlah anggota DPRD Jawa Barat

SELECT SUM(jumlah_anggota) AS TotalAnggotaDPRDJaBar
FROM jabarprov..AnggotaDPRD

-- Jumlah Kab/Kota JaBar

SELECT COUNT(DISTINCT(nama_kabupaten_kota)) AS TotalKabKotaJaBar
FROM jabarprov..AnggotaDPRD

-- Jumlah Partai

SELECT COUNT(DISTINCT(nama_partai)) AS TotalPartai
FROM jabarprov..AnggotaDPRD

-- Jumlah total anggota DPRD per kab/kota

SELECT nama_kabupaten_kota
, SUM(jumlah_anggota) AS TotalAnggotaPerKabKota
FROM jabarprov..AnggotaDPRD
GROUP BY nama_kabupaten_kota

-- Persentase anggota DPRD per kab/kota

CREATE TABLE #anggota_kab_kota (
TotalAnggota numeric,
nama_kabupaten_kota nvarchar(255),
TotalAnggotaPerKabKota numeric
)

INSERT INTO #anggota_kab_kota
SELECT (SELECT SUM(jumlah_anggota) FROM jabarprov..AnggotaDPRD) AS TotalAnggota
, nama_kabupaten_kota
, SUM(jumlah_anggota) AS TotalAnggotaPerkabKota
FROM jabarprov..AnggotaDPRD
GROUP BY nama_kabupaten_kota

SELECT *
, (TotalAnggotaPerKabKota/TotalAnggota) AS PersentaseAnggotaPerKabKota
FROM #anggota_kab_kota

-- Rata-rata anggota DPRD per Kab/Kota

SELECT AVG(TotalAnggotaPerKabKota) AS RataRata
FROM #anggota_kab_kota

-- Jumlah total anggota DPRD per partai

SELECT nama_partai
, SUM(jumlah_anggota) AS TotalAnggotaPerPartai
FROM jabarprov..AnggotaDPRD
GROUP BY nama_partai

-- Persentase anggota DPRD per partai

CREATE TABLE #anggota_partai (
TotalAnggota numeric,
nama_partai nvarchar(255),
TotalAnggotaPerPartai numeric
)

INSERT INTO #anggota_partai
SELECT (SELECT SUM(jumlah_anggota) FROM jabarprov..AnggotaDPRD) AS TotalAnggota
, nama_partai
, SUM(jumlah_anggota) AS TotalAnggotaPerPartai
FROM jabarprov..AnggotaDPRD
GROUP BY nama_partai

SELECT *
, (TotalAnggotaPerPartai/TotalAnggota) AS PersentaseAnggotaPerPartai
FROM #anggota_partai