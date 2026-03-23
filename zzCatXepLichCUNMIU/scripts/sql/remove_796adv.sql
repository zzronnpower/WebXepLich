BEGIN;

INSERT INTO nhom_hien_thi (ten_nhom, mau_nen)
SELECT 'CHUA_XEP', '#f4f4f4'
WHERE NOT EXISTS (
    SELECT 1 FROM nhom_hien_thi WHERE ten_nhom = 'CHUA_XEP'
);

WITH cn796 AS (
    SELECT id FROM chi_nhanh WHERE ma_chi_nhanh = '796' OR ten_chi_nhanh = '796ADV'
),
nhom796 AS (
    SELECT id FROM nhom_hien_thi WHERE ten_nhom = '796ADV'
),
chua_xep AS (
    SELECT id FROM nhom_hien_thi WHERE ten_nhom = 'CHUA_XEP' LIMIT 1
)
UPDATE lich_chi_tiet l
SET
    nhom_hien_thi_id = (SELECT id FROM chua_xep),
    chi_nhanh_id = NULL,
    ca_id = NULL
WHERE
    l.chi_nhanh_id IN (SELECT id FROM cn796)
    OR l.nhom_hien_thi_id IN (SELECT id FROM nhom796);

DELETE FROM nhu_cau_ca
WHERE chi_nhanh_id IN (
    SELECT id FROM chi_nhanh WHERE ma_chi_nhanh = '796' OR ten_chi_nhanh = '796ADV'
);

DELETE FROM mapping_nhom
WHERE chi_nhanh_id IN (
    SELECT id FROM chi_nhanh WHERE ma_chi_nhanh = '796' OR ten_chi_nhanh = '796ADV'
)
OR nhom_hien_thi_id IN (
    SELECT id FROM nhom_hien_thi WHERE ten_nhom = '796ADV'
);

DELETE FROM nhan_vien_chi_nhanh
WHERE chi_nhanh_id IN (
    SELECT id FROM chi_nhanh WHERE ma_chi_nhanh = '796' OR ten_chi_nhanh = '796ADV'
);

DELETE FROM nhom_hien_thi WHERE ten_nhom = '796ADV';
DELETE FROM chi_nhanh WHERE ma_chi_nhanh = '796' OR ten_chi_nhanh = '796ADV';

COMMIT;
