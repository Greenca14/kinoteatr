--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-04 15:28:59

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 17006)
-- Name: kinoteatr1; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA kinoteatr1;


ALTER SCHEMA kinoteatr1 OWNER TO postgres;

--
-- TOC entry 225 (class 1255 OID 17007)
-- Name: +2.1(); Type: FUNCTION; Schema: kinoteatr1; Owner: postgres
--

CREATE FUNCTION kinoteatr1."+2.1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF NEW."Рейтинг" <= 1 THEN 
		NEW."Рейтинг" = NEW."Рейтинг" + 2.1;
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION kinoteatr1."+2.1"() OWNER TO postgres;

--
-- TOC entry 226 (class 1255 OID 17008)
-- Name: bilet_place(); Type: FUNCTION; Schema: kinoteatr1; Owner: postgres
--

CREATE FUNCTION kinoteatr1.bilet_place() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE b bigint;
BEGIN 
	IF MAX("Место") < 150 FROM kinoteatr.Место THEN
		b = MAX("Место") + 1  FROM kinoteatr.Место;
		INSERT INTO kinoteatr.Место VALUES (b, true, NEW."id b", null);
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION kinoteatr1.bilet_place() OWNER TO postgres;

--
-- TOC entry 227 (class 1255 OID 17009)
-- Name: deleteKino(bigint); Type: PROCEDURE; Schema: kinoteatr1; Owner: postgres
--

CREATE PROCEDURE kinoteatr1."deleteKino"(IN a_id bigint)
    LANGUAGE sql
    AS $$
	DELETE FROM kinoteatr."Kino"
	WHERE a_id = "id";
	DELETE FROM kinoteatr."Сеанс"
	WHERE "id s" = a_id;
$$;


ALTER PROCEDURE kinoteatr1."deleteKino"(IN a_id bigint) OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 17010)
-- Name: film_seans(); Type: FUNCTION; Schema: kinoteatr1; Owner: postgres
--

CREATE FUNCTION kinoteatr1.film_seans() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE s time without time zone;
BEGIN 
	IF NEW."id" IS NOT null THEN
	s = NEW.Длительность + NOW() + '00:15:00';
		INSERT INTO kinoteatr.Сеанс VALUES (NOW() + '00:15:00', s, NEW."id", NEW."id", null, null);
	END IF;
	RETURN NEW;
END;
$$;


ALTER FUNCTION kinoteatr1.film_seans() OWNER TO postgres;

--
-- TOC entry 229 (class 1255 OID 17011)
-- Name: getfilmbyid(bigint); Type: FUNCTION; Schema: kinoteatr1; Owner: postgres
--

CREATE FUNCTION kinoteatr1.getfilmbyid(film_id bigint) RETURNS TABLE("Длительность" time without time zone, "Название" character varying)
    LANGUAGE sql
    AS $$
	SELECT "Длительность", "Название"
	FROM kinoteatr."Kino"
	WHERE id IN (
	SELECT "id s"
	FROM kinoteatr."Сеанс"
	WHERE "id s" = film_id )
$$;


ALTER FUNCTION kinoteatr1.getfilmbyid(film_id bigint) OWNER TO postgres;

--
-- TOC entry 230 (class 1255 OID 17012)
-- Name: percbymax(numeric); Type: FUNCTION; Schema: kinoteatr1; Owner: postgres
--

CREATE FUNCTION kinoteatr1.percbymax(perc numeric) RETURNS numeric
    LANGUAGE sql
    AS $$
	SELECT (MAX(k."Рейтинг"))*(100-perc)/100
	FROM kinoteatr."Kino" as k;
$$;


ALTER FUNCTION kinoteatr1.percbymax(perc numeric) OWNER TO postgres;

--
-- TOC entry 231 (class 1255 OID 17013)
-- Name: update_MES(); Type: PROCEDURE; Schema: kinoteatr1; Owner: postgres
--

CREATE PROCEDURE kinoteatr1."update_MES"()
    LANGUAGE sql
    AS $$	
	UPDATE kinoteatr."Место"
	SET "Свободно/Занято" = 'true'
	WHERE "Свободно/Занято" = 'false';
$$;


ALTER PROCEDURE kinoteatr1."update_MES"() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 17014)
-- Name: Kino; Type: TABLE; Schema: kinoteatr1; Owner: postgres
--

CREATE TABLE kinoteatr1."Kino" (
    id bigint NOT NULL,
    "Название" character varying(200) NOT NULL,
    "Длительность" time without time zone NOT NULL,
    "Рейтинг" numeric
);


ALTER TABLE kinoteatr1."Kino" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 17019)
-- Name: Сеанс; Type: TABLE; Schema: kinoteatr1; Owner: postgres
--

CREATE TABLE kinoteatr1."Сеанс" (
    "Начало фильма" time without time zone,
    "Конец фильма" time without time zone,
    "id s" bigint NOT NULL,
    "id k kino" bigint,
    "id k zaly" bigint,
    "День" timestamp without time zone
);


ALTER TABLE kinoteatr1."Сеанс" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 17022)
-- Name: RjoinKinoandSea; Type: VIEW; Schema: kinoteatr1; Owner: postgres
--

CREATE VIEW kinoteatr1."RjoinKinoandSea" AS
 SELECT kino.id,
    kino."Длительность",
    sea."Начало фильма",
    sea."id s"
   FROM (kinoteatr1."Kino" kino
     RIGHT JOIN kinoteatr1."Сеанс" sea ON ((kino.id = sea."id k kino")));


ALTER TABLE kinoteatr1."RjoinKinoandSea" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 17026)
-- Name: datebylong; Type: VIEW; Schema: kinoteatr1; Owner: postgres
--

CREATE VIEW kinoteatr1.datebylong AS
 SELECT kin.id,
    kin."Название",
    kin."Длительность"
   FROM kinoteatr1."Kino" kin
  WHERE (kin.id IN ( SELECT sea."id s"
           FROM kinoteatr1."Сеанс" sea
          WHERE (sea."День" = '2022-02-22 10:30:00'::timestamp without time zone)));


ALTER TABLE kinoteatr1.datebylong OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17030)
-- Name: Зал; Type: TABLE; Schema: kinoteatr1; Owner: postgres
--

CREATE TABLE kinoteatr1."Зал" (
    "Номер зала" bigint,
    "Стоимость" bigint,
    "id z" bigint NOT NULL
);


ALTER TABLE kinoteatr1."Зал" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17033)
-- Name: Место; Type: TABLE; Schema: kinoteatr1; Owner: postgres
--

CREATE TABLE kinoteatr1."Место" (
    "Место" bigint,
    "Свободно/Занято" boolean,
    id_m bigint NOT NULL,
    "id k zaly" bigint
);


ALTER TABLE kinoteatr1."Место" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17036)
-- Name: groupbyNamberZandplace; Type: VIEW; Schema: kinoteatr1; Owner: postgres
--

CREATE VIEW kinoteatr1."groupbyNamberZandplace" AS
 SELECT zal."Номер зала",
    count(mesto."Место") AS group1
   FROM kinoteatr1."Зал" zal,
    kinoteatr1."Место" mesto
  WHERE (mesto."Свободно/Занято" = true)
  GROUP BY zal."Номер зала";


ALTER TABLE kinoteatr1."groupbyNamberZandplace" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17040)
-- Name: Билет; Type: TABLE; Schema: kinoteatr1; Owner: postgres
--

CREATE TABLE kinoteatr1."Билет" (
    "Стоимость" bigint,
    "id b" bigint NOT NULL,
    "id k mes" bigint,
    "id k op" bigint,
    "id k sea" bigint
);


ALTER TABLE kinoteatr1."Билет" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17043)
-- Name: paytoticket500; Type: VIEW; Schema: kinoteatr1; Owner: postgres
--

CREATE VIEW kinoteatr1.paytoticket500 AS
 SELECT "Билет"."Стоимость",
    "Билет"."id b",
    "Билет"."id k mes",
    "Билет"."id k op",
    "Билет"."id k sea"
   FROM kinoteatr1."Билет"
  WHERE ("Билет"."Стоимость" = 500)
  WITH CASCADED CHECK OPTION;


ALTER TABLE kinoteatr1.paytoticket500 OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17047)
-- Name: О пользователе; Type: TABLE; Schema: kinoteatr1; Owner: postgres
--

CREATE TABLE kinoteatr1."О пользователе" (
    "Почта" character varying(200) NOT NULL,
    "id p" bigint NOT NULL
);


ALTER TABLE kinoteatr1."О пользователе" OWNER TO postgres;

--
-- TOC entry 3384 (class 0 OID 17014)
-- Dependencies: 215
-- Data for Name: Kino; Type: TABLE DATA; Schema: kinoteatr1; Owner: postgres
--

INSERT INTO kinoteatr1."Kino" (id, "Название", "Длительность", "Рейтинг") VALUES (2, 'Аватар', '02:30:00', 9.2);
INSERT INTO kinoteatr1."Kino" (id, "Название", "Длительность", "Рейтинг") VALUES (3, 'Блогеры и дороги
', '01:30:00', 3.1);
INSERT INTO kinoteatr1."Kino" (id, "Название", "Длительность", "Рейтинг") VALUES (1, 'Интерстеллар', '03:00:00', 5);
INSERT INTO kinoteatr1."Kino" (id, "Название", "Длительность", "Рейтинг") VALUES (5, 'Какой-то фильм', '02:00:00', NULL);


--
-- TOC entry 3388 (class 0 OID 17040)
-- Dependencies: 222
-- Data for Name: Билет; Type: TABLE DATA; Schema: kinoteatr1; Owner: postgres
--

INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (500, 2, 2, 2, 2);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (600, 3, 3, 3, 3);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (400, 4, 4, 1, 1);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (500, 5, 5, 2, 2);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (300, 6, 6, 3, 3);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (450, 7, 7, 3, 2);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (700, 8, 8, 2, 3);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (300, 9, 9, 1, 1);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (450, 10, 5, 1, 2);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (500, 11, 11, 2, 2);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (600, 12, 12, 2, 2);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (250, 1, 1, 1, 1);
INSERT INTO kinoteatr1."Билет" ("Стоимость", "id b", "id k mes", "id k op", "id k sea") VALUES (555, 16, NULL, NULL, NULL);


--
-- TOC entry 3386 (class 0 OID 17030)
-- Dependencies: 219
-- Data for Name: Зал; Type: TABLE DATA; Schema: kinoteatr1; Owner: postgres
--

INSERT INTO kinoteatr1."Зал" ("Номер зала", "Стоимость", "id z") VALUES (1, 450, 1);
INSERT INTO kinoteatr1."Зал" ("Номер зала", "Стоимость", "id z") VALUES (4, 300, 3);
INSERT INTO kinoteatr1."Зал" ("Номер зала", "Стоимость", "id z") VALUES (7, 500, 2);


--
-- TOC entry 3387 (class 0 OID 17033)
-- Dependencies: 220
-- Data for Name: Место; Type: TABLE DATA; Schema: kinoteatr1; Owner: postgres
--

INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (24, true, 2, 2);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (55, true, 9, 3);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (11, true, 8, 2);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (45, true, 7, 1);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (12, true, 6, 3);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (32, true, 3, 2);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (44, true, 4, 1);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (78, false, 5, 2);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (31, false, 1, 1);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (NULL, NULL, 11, 3);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (NULL, NULL, 12, NULL);
INSERT INTO kinoteatr1."Место" ("Место", "Свободно/Занято", id_m, "id k zaly") VALUES (79, true, 16, NULL);


--
-- TOC entry 3389 (class 0 OID 17047)
-- Dependencies: 224
-- Data for Name: О пользователе; Type: TABLE DATA; Schema: kinoteatr1; Owner: postgres
--

INSERT INTO kinoteatr1."О пользователе" ("Почта", "id p") VALUES ('yakovlev_av@edu.surgu.ru', 2);
INSERT INTO kinoteatr1."О пользователе" ("Почта", "id p") VALUES ('cheremnikh_yup@edu.surgu.ru', 1);
INSERT INTO kinoteatr1."О пользователе" ("Почта", "id p") VALUES ('shyvalov_ia@edu.surgu.ru', 3);


--
-- TOC entry 3385 (class 0 OID 17019)
-- Dependencies: 216
-- Data for Name: Сеанс; Type: TABLE DATA; Schema: kinoteatr1; Owner: postgres
--

INSERT INTO kinoteatr1."Сеанс" ("Начало фильма", "Конец фильма", "id s", "id k kino", "id k zaly", "День") VALUES ('10:45:00', '13:45:00', 1, 1, 1, '2022-02-22 10:30:00');
INSERT INTO kinoteatr1."Сеанс" ("Начало фильма", "Конец фильма", "id s", "id k kino", "id k zaly", "День") VALUES ('18:15:00', '20:45:00', 2, 2, 2, '2022-02-23 18:00:00');
INSERT INTO kinoteatr1."Сеанс" ("Начало фильма", "Конец фильма", "id s", "id k kino", "id k zaly", "День") VALUES ('19:15:00', '21:45:00', 3, 3, 3, '2022-02-02 19:00:00');
INSERT INTO kinoteatr1."Сеанс" ("Начало фильма", "Конец фильма", "id s", "id k kino", "id k zaly", "День") VALUES ('23:14:20.404314', '01:14:20.404314', 5, 5, NULL, NULL);


--
-- TOC entry 3217 (class 2606 OID 17051)
-- Name: Kino Kino_pkey; Type: CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Kino"
    ADD CONSTRAINT "Kino_pkey" PRIMARY KEY (id);


--
-- TOC entry 3225 (class 2606 OID 17053)
-- Name: Билет Билет_pkey; Type: CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Билет"
    ADD CONSTRAINT "Билет_pkey" PRIMARY KEY ("id b");


--
-- TOC entry 3221 (class 2606 OID 17055)
-- Name: Зал Зал_pkey; Type: CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Зал"
    ADD CONSTRAINT "Зал_pkey" PRIMARY KEY ("id z");


--
-- TOC entry 3223 (class 2606 OID 17057)
-- Name: Место Место_pkey; Type: CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Место"
    ADD CONSTRAINT "Место_pkey" PRIMARY KEY (id_m);


--
-- TOC entry 3227 (class 2606 OID 17059)
-- Name: О пользователе О пользователе_pkey; Type: CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."О пользователе"
    ADD CONSTRAINT "О пользователе_pkey" PRIMARY KEY ("id p");


--
-- TOC entry 3219 (class 2606 OID 17061)
-- Name: Сеанс Сеанс_pkey; Type: CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Сеанс"
    ADD CONSTRAINT "Сеанс_pkey" PRIMARY KEY ("id s");


--
-- TOC entry 3237 (class 2620 OID 17062)
-- Name: Билет bilet_place; Type: TRIGGER; Schema: kinoteatr1; Owner: postgres
--

CREATE TRIGGER bilet_place AFTER INSERT ON kinoteatr1."Билет" FOR EACH ROW EXECUTE FUNCTION kinoteatr1.bilet_place();


--
-- TOC entry 3236 (class 2620 OID 17063)
-- Name: Место bilet_place; Type: TRIGGER; Schema: kinoteatr1; Owner: postgres
--

CREATE TRIGGER bilet_place AFTER UPDATE ON kinoteatr1."Место" FOR EACH ROW EXECUTE FUNCTION kinoteatr1.bilet_place();


--
-- TOC entry 3234 (class 2620 OID 17064)
-- Name: Kino delfilm; Type: TRIGGER; Schema: kinoteatr1; Owner: postgres
--

CREATE TRIGGER delfilm BEFORE UPDATE ON kinoteatr1."Kino" FOR EACH ROW EXECUTE FUNCTION kinoteatr1."+2.1"();


--
-- TOC entry 3235 (class 2620 OID 17065)
-- Name: Kino film_seans; Type: TRIGGER; Schema: kinoteatr1; Owner: postgres
--

CREATE TRIGGER film_seans AFTER INSERT ON kinoteatr1."Kino" FOR EACH ROW EXECUTE FUNCTION kinoteatr1.film_seans();


--
-- TOC entry 3228 (class 2606 OID 17066)
-- Name: Сеанс id k kino; Type: FK CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Сеанс"
    ADD CONSTRAINT "id k kino" FOREIGN KEY ("id k kino") REFERENCES kinoteatr1."Kino"(id) NOT VALID;


--
-- TOC entry 3231 (class 2606 OID 17071)
-- Name: Билет id k mes; Type: FK CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Билет"
    ADD CONSTRAINT "id k mes" FOREIGN KEY ("id k mes") REFERENCES kinoteatr1."Место"(id_m) NOT VALID;


--
-- TOC entry 3232 (class 2606 OID 17076)
-- Name: Билет id k opo; Type: FK CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Билет"
    ADD CONSTRAINT "id k opo" FOREIGN KEY ("id k op") REFERENCES kinoteatr1."О пользователе"("id p") NOT VALID;


--
-- TOC entry 3233 (class 2606 OID 17081)
-- Name: Билет id k sea; Type: FK CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Билет"
    ADD CONSTRAINT "id k sea" FOREIGN KEY ("id k sea") REFERENCES kinoteatr1."Сеанс"("id s") NOT VALID;


--
-- TOC entry 3229 (class 2606 OID 17086)
-- Name: Сеанс id k zaly; Type: FK CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Сеанс"
    ADD CONSTRAINT "id k zaly" FOREIGN KEY ("id k zaly") REFERENCES kinoteatr1."Зал"("id z") NOT VALID;


--
-- TOC entry 3230 (class 2606 OID 17091)
-- Name: Место id k zaly; Type: FK CONSTRAINT; Schema: kinoteatr1; Owner: postgres
--

ALTER TABLE ONLY kinoteatr1."Место"
    ADD CONSTRAINT "id k zaly" FOREIGN KEY ("id k zaly") REFERENCES kinoteatr1."Зал"("id z") NOT VALID;


-- Completed on 2023-05-04 15:29:00

--
-- PostgreSQL database dump complete
--

