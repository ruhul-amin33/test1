-- ONLY for an OLD database made from the first version (bazarghor_database.sql).
-- If you imported rumedio_database.sql on a fresh database, you do NOT need this file.
-- Run in phpMyAdmin > SQL tab. If a line says "Duplicate column", that column already exists: skip that line.

ALTER TABLE categories ADD COLUMN has_sizes TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE products ADD COLUMN is_out_of_stock TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE products ADD COLUMN hide_stock TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE orders ADD COLUMN zone ENUM('dhaka','outside') NOT NULL DEFAULT 'dhaka';
ALTER TABLE orders ADD COLUMN discount DECIMAL(10,2) NOT NULL DEFAULT 0;
ALTER TABLE orders ADD COLUMN voucher_code VARCHAR(30) DEFAULT NULL;
ALTER TABLE orders ADD COLUMN shipping_mode ENUM('auto','free','custom') NOT NULL DEFAULT 'auto';
ALTER TABLE order_items ADD COLUMN color VARCHAR(30) DEFAULT NULL;
ALTER TABLE order_items ADD COLUMN size VARCHAR(20) DEFAULT NULL;
-- Then run database/schema.sql too: it creates the new tables
-- (product_images, product_variants, vouchers, slides, settings) without touching existing data.
