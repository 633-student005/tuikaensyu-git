-- �X�L�[�}�̌������폜���Ă��烍�[�����폜
REVOKE ALL ON SCHEMA public FROM yuki; -- �X�L�[�}�̌����폜
REVOKE ALL PRIVILEGES ON DATABASE library_managementdb FROM yuki; -- �f�[�^�x�[�X�̌����폜

-- ���[�U�[�폜
DO $$ 
BEGIN
   IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'yuki') THEN
       DROP USER yuki; -- ���[���폜
   END IF;
END $$;

-- �f�[�^�x�[�X�폜
-- DROP DATABASE �͒��ڎ��s���Ă��������BPL/pgSQL�֐��ł͎��s�ł��܂���B
DROP DATABASE IF EXISTS library_managementdb;

-- �f�[�^�x�[�X�쐬
CREATE DATABASE library_managementdb;

-- �f�[�^�x�[�X�ɐڑ�
\c library_managementdb;

-- �V�������[�����쐬
DO $$ 
BEGIN
   IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'yuki') THEN
       CREATE USER yuki WITH PASSWORD 'himitu';
   END IF;
END $$;

-- yuki�Ƀf�[�^�x�[�X�S�̂ւ̌�����t�^
GRANT ALL PRIVILEGES ON DATABASE library_managementdb TO yuki;

-- yuki�ɃX�L�[�} public �̂��ׂĂ̌�����t�^
GRANT ALL ON SCHEMA public TO yuki;

-- yuki�Ɋ����̂��ׂẴe�[�u���ւ̌�����t�^
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO yuki;

-- yuki�Ɋ����̂��ׂẴV�[�P���X�ւ̌�����t�^
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO yuki;

-- yuki�ɍ���쐬����邷�ׂẴe�[�u���ւ̌����������t�^
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO yuki;

-- yuki�ɍ���쐬����邷�ׂẴV�[�P���X�ւ̌����������t�^
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO yuki;

-- �e�[�u���폜�����i���݂���ꍇ�̂݁j
DROP TABLE IF EXISTS borrowing_ledger CASCADE; -- �ݏo�Ǘ��e�[�u��
DROP TABLE IF EXISTS reservation_ledger CASCADE; -- �\��Ǘ��e�[�u��
DROP TABLE IF EXISTS inventory_ledger CASCADE; -- �݌ɊǗ��e�[�u��
DROP TABLE IF EXISTS document_catalog CASCADE; -- �����J�^���O�e�[�u��
DROP TABLE IF EXISTS category_code_table CASCADE; -- ���ރR�[�h�e�[�u��
DROP TABLE IF EXISTS members_ledger CASCADE; -- ������e�[�u��

-- ������e�[�u��
CREATE TABLE members_ledger (
    members_id SERIAL PRIMARY KEY, -- ���ID (��L�[�A��������)
    name VARCHAR(255) NOT NULL, -- ����
    postal_code CHAR(8) NOT NULL CHECK (postal_code ~ '^\d{3}-\d{4}$'), -- �X�֔ԍ� (�`���`�F�b�N)
    address VARCHAR(255) NOT NULL, -- �Z��
    phone_number VARCHAR NOT NULL, -- �d�b�ԍ�
    email VARCHAR(255) UNIQUE, -- Email (��Ӑ�)
    birthdate DATE NOT NULL, -- ���N����
    admission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- ����N���� (�����l: ���ݓ���)
    unsubscribe_date TIMESTAMP DEFAULT NULL, -- �މ�N���� (�����l: NULL)
    password VARCHAR(255) NOT NULL, -- �p�X���[�h
    admin_flag BOOLEAN DEFAULT FALSE NOT NULL -- �Ǘ��Ҍ��� (�����l: FALSE)
);

-- ���ރR�[�h�e�[�u��
CREATE TABLE category_code_table (
    classification_code SERIAL PRIMARY KEY, -- ���ރR�[�h (��L�[�A��������)
    class_eye_name VARCHAR(255) NOT NULL -- �ޖږ�
);

-- �����J�^���O�e�[�u��
CREATE TABLE document_catalog (
    document_id SERIAL PRIMARY KEY, -- ����ID (��L�[�A��������)
    isbn_number VARCHAR(13) NOT NULL UNIQUE, -- ISBN�ԍ� (��Ӑ�)
    document_name VARCHAR(255) NOT NULL, -- ������
    classification_code INTEGER NOT NULL REFERENCES category_code_table(classification_code), -- ���ރR�[�h (�O���L�[)
    author VARCHAR(255) NOT NULL, -- ����
    publisher VARCHAR(255) NOT NULL, -- �o�Ŏ�
    publication_date DATE NOT NULL -- �o�œ�
);

-- �ݏo�Ǘ��e�[�u��
CREATE TABLE borrowing_ledger (
    borrowing_id SERIAL PRIMARY KEY, -- �ݏoID (��L�[�A��������)
    members_id INTEGER NOT NULL REFERENCES members_ledger(members_id), -- ���ID (�O���L�[)
    document_id INTEGER NOT NULL REFERENCES document_catalog(document_id), -- ����ID (�O���L�[)
    borrowing_date TIMESTAMP NOT NULL, -- �ݏo�N����
    return_deadline TIMESTAMP NOT NULL, -- �ԋp����
    return_date TIMESTAMP DEFAULT NULL -- �ԋp�N���� (�����l: NULL)
);

-- �\��Ǘ��e�[�u��
CREATE TABLE reservation_ledger (
    reservation_id SERIAL PRIMARY KEY, -- �\��ID (��L�[�A��������)
    members_id INTEGER NOT NULL REFERENCES members_ledger(members_id), -- ���ID (�O���L�[)
    isbn_number VARCHAR(13) NOT NULL, -- ISBN�ԍ�
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, -- �\��N���� (�����l: ���ݓ���)
    ensured_document_id INTEGER REFERENCES document_catalog(document_id) -- �m�ۍςݎ���ID (�O���L�[)
);

-- �݌ɊǗ��e�[�u��
CREATE TABLE inventory_ledger (
    document_id SERIAL PRIMARY KEY, -- ����ID (��L�[�A��������)
    isbn_number VARCHAR(13) NOT NULL, -- ISBN�ԍ�
    document_name VARCHAR(255) NOT NULL, -- ������
    arrival_date TIMESTAMP NOT NULL, -- ���הN����
    disposal_date TIMESTAMP DEFAULT NULL -- �p���N���� (�����l: NULL)
);
