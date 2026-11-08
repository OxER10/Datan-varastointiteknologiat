DROP DATABASE IF EXISTS company;
CREATE DATABASE company CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci;
USE company;

CREATE TABLE drone (
    drone_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nimi         VARCHAR(50)  NOT NULL,
    merkki       VARCHAR(50)  NOT NULL,
    malli        VARCHAR(80)  NOT NULL,
    sarjanumero  VARCHAR(40)  NOT NULL,
    lisatiedot   TEXT         NULL,
    PRIMARY KEY (drone_id),
    UNIQUE KEY uq_drone_nimi (nimi),
    UNIQUE KEY uq_drone_sarjanumero (sarjanumero)
) ENGINE=InnoDB;

CREATE TABLE kayttaja (
    kayttaja_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    etunimi         VARCHAR(50)  NOT NULL,
    sukunimi        VARCHAR(50)  NOT NULL,
    kayttajatunnus  VARCHAR(30)  NOT NULL,
    salasana_hash   CHAR(64)     NOT NULL,
    token_hash      CHAR(64)     NULL,
    luotu           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (kayttaja_id),
    UNIQUE KEY uq_kayttaja_tunnus (kayttajatunnus)
) ENGINE=InnoDB;

CREATE TABLE lentotapahtuma (
    lento_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    drone_id     INT UNSIGNED NOT NULL,
    kayttaja_id  INT UNSIGNED NOT NULL,
    alkoi        DATETIME     NOT NULL,
    paattyi      DATETIME     NULL,
    tarkoitus    VARCHAR(200) NULL,
    PRIMARY KEY (lento_id),
    KEY idx_lento_drone_aika (drone_id, alkoi, paattyi),
    KEY idx_lento_kayttaja (kayttaja_id),
    CONSTRAINT fk_lento_drone
        FOREIGN KEY (drone_id) REFERENCES drone (drone_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_lento_kayttaja
        FOREIGN KEY (kayttaja_id) REFERENCES kayttaja (kayttaja_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_lento_aika CHECK (paattyi IS NULL OR paattyi > alkoi)
) ENGINE=InnoDB;

CREATE TABLE kuva (
    kuva_id        INT UNSIGNED  NOT NULL AUTO_INCREMENT,
    lento_id       INT UNSIGNED  NOT NULL,
    kuvan_nimi     VARCHAR(100)  NOT NULL,
    tiedostopolku  VARCHAR(255)  NOT NULL,
    kuvausaika     DATETIME      NOT NULL,
    leveysaste     DECIMAL(8,6)  NOT NULL,
    pituusaste     DECIMAL(9,6)  NOT NULL,
    PRIMARY KEY (kuva_id),
    KEY idx_kuva_lento (lento_id),
    CONSTRAINT fk_kuva_lento
        FOREIGN KEY (lento_id) REFERENCES lentotapahtuma (lento_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_kuva_leveysaste CHECK (leveysaste BETWEEN -90 AND 90),
    CONSTRAINT chk_kuva_pituusaste CHECK (pituusaste BETWEEN -180 AND 180)
) ENGINE=InnoDB;

CREATE TABLE analyysi (
    analyysi_id  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    kuva_id      INT UNSIGNED NOT NULL,
    kuvaus       TEXT         NOT NULL,
    analysoitu   DATETIME     NOT NULL,
    PRIMARY KEY (analyysi_id),
    KEY idx_analyysi_kuva (kuva_id),
    CONSTRAINT fk_analyysi_kuva
        FOREIGN KEY (kuva_id) REFERENCES kuva (kuva_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;