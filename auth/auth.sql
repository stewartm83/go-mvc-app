CREATE DATABASE openid_auth;

CREATE TABLE users (
  id                    SERIAL,
  user_name             VARCHAR(60)  NOT NULL,
  first_name            VARCHAR(60)  NOT NULL,
  last_name             VARCHAR(60)  NOT NULL,
  middle_name           VARCHAR(60)  NULL,
  nick_name             VARCHAR(60)  NULL,
  preferred_username    VARCHAR(60)  NULL,
  profile               VARCHAR(200) NULL,
  picture               VARCHAR(200) NULL,
  website               VARCHAR(200) NULL,
  email                 VARCHAR(200) NOT NULL,
  email_verified        boolean      NULL,
  gender                VARCHAR(20)  NULL,
  birthdate             VARCHAR(30)  NULL,
  zoneinfo              VARCHAR(100) NULL,
  phone_number          VARCHAR(20)  NULL,
  phone_number_verified boolean      NULL,
  address_id            INT          NULL,
  updated_at            numeric      NOT NULL,
  CONSTRAINT user_id_pkey PRIMARY KEY (id)
);

create table address (
  id             SERIAL,
  street_address VARCHAR(200) NULL,
  city           VARCHAR(100) NULL,
  region         VARCHAR(60)  NULL,
  postal_code    VARCHAR(20)  NULL,
  country        VARCHAR(100) NULL,
  CONSTRAINT address_id_pkey PRIMARY KEY (id)
);

CREATE TABLE roles (
  id   SERIAL,
  name VARCHAR(100) NOT NULL,
  CONSTRAINT role_id_pkey PRIMARY KEY (id)
);

CREATE TABLE claims (
  id          SERIAL,
  user_id     INT,
  claim_type  VARCHAR(50),
  claim_value VARCHAR(200),
  CONSTRAINT claim_id_pkey PRIMARY KEY (id)
);


CREATE TABLE auth_provider (
  id            SERIAL,
  provider_name VARCHAR(50),
  provider_key  VARCHAR(50),
  user_id       INT,
  CONSTRAINT auth_provider_id_pkey PRIMARY KEY (id)
);

CREATE TABLE user_roles (
  user_id INT,
  role_id INT,
  CONSTRAINT user_role_pkey PRIMARY KEY (user_id, role_id)
);

ALTER TABLE claims
  ADD CONSTRAINT claims_user_id_fkey FOREIGN KEY (user_id)
REFERENCES users (id) MATCH SIMPLE
ON UPDATE SET DEFAULT
ON DELETE SET DEFAULT;
CREATE INDEX fki_claims_user_id_fkey
  ON claims (user_id);

ALTER TABLE user_roles
  ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id)
REFERENCES users (id) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE SET NULL;
CREATE INDEX fki_user_role_user_id_fkey
  ON user_roles (user_id);

ALTER TABLE user_roles
  ADD CONSTRAINT user_role_role_id_fkey FOREIGN KEY (role_id)
REFERENCES roles (id) MATCH SIMPLE
ON UPDATE CASCADE
ON DELETE SET NULL;
CREATE INDEX fki_user_role_role_id_fkey
  ON user_roles (role_id);