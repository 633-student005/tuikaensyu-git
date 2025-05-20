-- スキーマの権限を削除してからロールを削除
REVOKE ALL ON SCHEMA public FROM yuki; -- スキーマの権限削除
REVOKE ALL PRIVILEGES ON DATABASE library_managementdb FROM yuki; -- データベースの権限削除

-- ユーザー削除
DO $$ 
BEGIN
   IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'yuki') THEN
       DROP USER yuki; -- ロール削除
   END IF;
END $$;

-- データベース削除
-- DROP DATABASE は直接実行してください。PL/pgSQL関数では実行できません。
DROP DATABASE IF EXISTS library_managementdb;

-- データベース作成
CREATE DATABASE library_managementdb;

-- データベースに接続
\c library_managementdb;

-- 新しいロールを作成
DO $$ 
BEGIN
   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'yuki') THEN
       CREATE USER yuki WITH PASSWORD 'himitu';
   END IF;
END $$;

-- yukiにデータベース全体への権限を付与
GRANT ALL PRIVILEGES ON DATABASE library_managementdb TO yuki;

-- yukiにスキーマ public のすべての権限を付与
GRANT ALL ON SCHEMA public TO yuki;

-- yukiに既存のすべてのテーブルへの権限を付与
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO yuki;

-- yukiに既存のすべてのシーケンスへの権限を付与
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO yuki;

-- yukiに今後作成されるすべてのテーブルへの権限を自動付与
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO yuki;

-- yukiに今後作成されるすべてのシーケンスへの権限を自動付与
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO yuki;

-- テーブル削除処理（存在する場合のみ）
DROP TABLE IF EXISTS borrowing_ledger CASCADE; -- 貸出管理テーブル
DROP TABLE IF EXISTS reservation_ledger CASCADE; -- 予約管理テーブル
DROP TABLE IF EXISTS inventory_ledger CASCADE; -- 在庫管理テーブル
DROP TABLE IF EXISTS document_catalog CASCADE; -- 資料カタログテーブル
DROP TABLE IF EXISTS category_code_table CASCADE; -- 分類コードテーブル
DROP TABLE IF EXISTS members_ledger CASCADE; -- 会員情報テーブル

-- 会員情報テーブル
CREATE TABLE members_ledger (
    members_id SERIAL PRIMARY KEY, -- 会員ID (主キー、自動増分)
    name VARCHAR(255) NOT NULL, -- 氏名
    postal_code CHAR(8) NOT NULL CHECK (postal_code ~ '^\d{3}-\d{4}$'), -- 郵便番号 (形式チェック)
    address VARCHAR(255) NOT NULL, -- 住所
    phone_number VARCHAR NOT NULL, -- 電話番号
    email VARCHAR(255) UNIQUE, -- Email (一意性)
    birthdate DATE NOT NULL, -- 生年月日
    admission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 入会年月日 (初期値: 現在日時)
    unsubscribe_date TIMESTAMP DEFAULT NULL, -- 退会年月日 (初期値: NULL)
    password VARCHAR(255) NOT NULL, -- パスワード
    admin_flag BOOLEAN DEFAULT FALSE NOT NULL -- 管理者権限 (初期値: FALSE)
);

-- 分類コードテーブル
CREATE TABLE category_code_table (
    classification_code SERIAL PRIMARY KEY, -- 分類コード (主キー、自動増分)
    class_eye_name VARCHAR(255) NOT NULL -- 類目名
);

-- 資料カタログテーブル
CREATE TABLE document_catalog (
    document_id SERIAL PRIMARY KEY, -- 資料ID (主キー、自動増分)
    isbn_number VARCHAR(13) NOT NULL UNIQUE, -- ISBN番号 (一意性)
    document_name VARCHAR(255) NOT NULL, -- 資料名
    classification_code INTEGER NOT NULL REFERENCES category_code_table(classification_code), -- 分類コード (外部キー)
    author VARCHAR(255) NOT NULL, -- 著者
    publisher VARCHAR(255) NOT NULL, -- 出版社
    publication_date DATE NOT NULL -- 出版日
);

-- 貸出管理テーブル
CREATE TABLE borrowing_ledger (
    borrowing_id SERIAL PRIMARY KEY, -- 貸出ID (主キー、自動増分)
    members_id INTEGER NOT NULL REFERENCES members_ledger(members_id), -- 会員ID (外部キー)
    document_id INTEGER NOT NULL REFERENCES document_catalog(document_id), -- 資料ID (外部キー)
    borrowing_date TIMESTAMP NOT NULL, -- 貸出年月日
    return_deadline TIMESTAMP NOT NULL, -- 返却期日
    return_date TIMESTAMP DEFAULT NULL -- 返却年月日 (初期値: NULL)
);

-- 予約管理テーブル
CREATE TABLE reservation_ledger (
    reservation_id SERIAL PRIMARY KEY, -- 予約ID (主キー、自動増分)
    members_id INTEGER NOT NULL REFERENCES members_ledger(members_id), -- 会員ID (外部キー)
    isbn_number VARCHAR(13) NOT NULL, -- ISBN番号
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- 予約年月日 (初期値: 現在日時)
    ensured_document_id INTEGER REFERENCES document_catalog(document_id) -- 確保済み資料ID (外部キー)
);

-- 在庫管理テーブル
CREATE TABLE inventory_ledger (
    document_id SERIAL PRIMARY KEY, -- 資料ID (主キー、自動増分)
    isbn_number VARCHAR(13) NOT NULL, -- ISBN番号
    document_name VARCHAR(255) NOT NULL, -- 資料名
    arrival_date TIMESTAMP NOT NULL, -- 入荷年月日
    disposal_date TIMESTAMP DEFAULT NULL -- 廃棄年月日 (初期値: NULL)
);
