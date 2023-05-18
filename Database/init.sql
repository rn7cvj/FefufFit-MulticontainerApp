--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

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
-- Name: bookingstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.bookingstatus AS ENUM (
    'booked',
    'paid',
    'cancelled',
    'done'
);


ALTER TYPE public.bookingstatus OWNER TO postgres;

--
-- Name: userstatuses; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.userstatuses AS ENUM (
    'student',
    'employee',
    'guest'
);


ALTER TYPE public.userstatuses OWNER TO postgres;

--
-- Name: usertypes; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.usertypes AS ENUM (
    'admin',
    'coach',
    'regular_user',
    'superadmin',
    'moderator'
);


ALTER TYPE public.usertypes OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: area; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.area (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    building_id integer,
    description text,
    photo character varying
);


ALTER TABLE public.area OWNER TO postgres;

--
-- Name: area_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.area_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.area_id_seq OWNER TO postgres;

--
-- Name: area_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.area_id_seq OWNED BY public.area.id;


--
-- Name: booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    user_id integer NOT NULL,
    event_id integer NOT NULL,
    status public.bookingstatus NOT NULL
);


ALTER TABLE public.booking OWNER TO postgres;

--
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.booking_id_seq OWNER TO postgres;

--
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- Name: building; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text,
    photo character varying(500)
);


ALTER TABLE public.building OWNER TO postgres;

--
-- Name: building_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.building_id_seq OWNER TO postgres;

--
-- Name: building_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_id_seq OWNED BY public.building.id;


--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id integer NOT NULL,
    first_name text,
    second_name text,
    third_name text,
    email text NOT NULL,
    password text NOT NULL,
    type public.usertypes,
    photo text,
    birthdate text,
    gender character varying(1),
    status public.userstatuses,
    phone_number character varying(50),
    telegram_id character varying(50),
    workout_count integer,
    verified boolean
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_id_seq OWNER TO postgres;

--
-- Name: client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;


--
-- Name: coach; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coach (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(200) NOT NULL,
    phone_number character varying(20),
    email character varying(100),
    building_id integer
);


ALTER TABLE public.coach OWNER TO postgres;

--
-- Name: coach_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coach_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coach_id_seq OWNER TO postgres;

--
-- Name: coach_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.coach_id_seq OWNED BY public.coach.id;


--
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    begin timestamp without time zone NOT NULL,
    "end" timestamp without time zone NOT NULL,
    service_id integer,
    building_id integer NOT NULL,
    area_id integer NOT NULL,
    coach_id integer,
    description text,
    capacity integer NOT NULL,
    booked integer NOT NULL,
    visibility boolean
);


ALTER TABLE public.event OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_id_seq OWNER TO postgres;

--
-- Name: event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.event_id_seq OWNED BY public.event.id;


--
-- Name: service; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    description text,
    photo character varying(200),
    cost integer
);


ALTER TABLE public.service OWNER TO postgres;

--
-- Name: service_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.service_id_seq OWNER TO postgres;

--
-- Name: service_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_id_seq OWNED BY public.service.id;


--
-- Name: area id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area ALTER COLUMN id SET DEFAULT nextval('public.area_id_seq'::regclass);


--
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- Name: building id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building ALTER COLUMN id SET DEFAULT nextval('public.building_id_seq'::regclass);


--
-- Name: client id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id SET DEFAULT nextval('public.client_id_seq'::regclass);


--
-- Name: coach id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach ALTER COLUMN id SET DEFAULT nextval('public.coach_id_seq'::regclass);


--
-- Name: event id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event ALTER COLUMN id SET DEFAULT nextval('public.event_id_seq'::regclass);


--
-- Name: service id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service ALTER COLUMN id SET DEFAULT nextval('public.service_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.alembic_version VALUES ('8ce1194e543d');


--
-- Data for Name: area; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.area VALUES (1, 'Зал аэробики', 1, NULL, NULL);
INSERT INTO public.area VALUES (2, 'Зал единоборств', 2, NULL, NULL);
INSERT INTO public.area VALUES (3, 'Бассейн', 2, NULL, NULL);


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.booking VALUES (1, 1, 14, 'booked');
INSERT INTO public.booking VALUES (2, 1, 11, 'booked');
INSERT INTO public.booking VALUES (3, 1, 16, 'booked');
INSERT INTO public.booking VALUES (4, 1, 18, 'booked');


--
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.building VALUES (1, 'S1', 'описание1', NULL);
INSERT INTO public.building VALUES (2, 'S2', NULL, NULL);
INSERT INTO public.building VALUES (0, 'S1', NULL, 'null');


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client VALUES (1, '123', '123', '123', '123@mail.ru', 'pbkdf2:sha256:600000$tyWrOMdClDq0TiI7$bfd6a73fffa337bdadd4d643efb83eb1c181af5e9513cfd7610f2beb6d04d65c', 'admin', NULL, '2005-05-14 00:00:00', 'm', 'student', '123456789', NULL, 0, false);
INSERT INTO public.client VALUES (2, 'coach', 'coach', 'coach', 'coach@mail.ru', 'pbkdf2:sha256:600000$swsLV7LCDugvollW$7c703e56193d553ec0f13812b21ddca255855ac2e50ae138ec45fc322fbbf761', 'coach', NULL, '2005-05-16 00:00:00', 'm', 'student', '12345678910', NULL, 0, false);


--
-- Data for Name: coach; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.coach VALUES (1, 2, 'coach', '12345678910', 'coach@mail.ru', 0);


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event VALUES (1, 'Обучение плаванию детей', '2023-05-14 18:00:00', '2023-05-14 19:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (2, 'Обучение плаванию детей', '2023-05-14 10:00:00', '2023-05-14 11:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (3, 'Свободное плавание', '2023-05-14 18:00:00', '2023-05-14 19:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (4, 'Свободное плавание', '2023-05-14 10:00:00', '2023-05-14 11:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (5, 'Обучение плаванию детей', '2023-05-15 18:00:00', '2023-05-15 19:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (6, 'Обучение плаванию детей', '2023-05-15 10:00:00', '2023-05-15 11:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (7, 'Свободное плавание', '2023-05-15 18:00:00', '2023-05-15 19:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (8, 'Свободное плавание', '2023-05-15 10:00:00', '2023-05-15 11:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (9, 'Обучение плаванию детей', '2023-05-16 17:00:00', '2023-05-16 18:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (10, 'Обучение плаванию детей', '2023-05-16 18:00:00', '2023-05-16 19:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (12, 'Свободное плавание', '2023-05-16 17:00:00', '2023-05-16 18:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (13, 'Свободное плавание', '2023-05-16 18:00:00', '2023-05-16 19:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (15, 'Обучение плаванию детей', '2023-05-17 18:00:00', '2023-05-17 19:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (17, 'Свободное плавание', '2023-05-17 18:00:00', '2023-05-17 19:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (19, 'Обучение плаванию детей', '2023-05-18 18:00:00', '2023-05-18 19:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (20, 'Обучение плаванию детей', '2023-05-18 10:00:00', '2023-05-18 11:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (21, 'Свободное плавание', '2023-05-18 18:00:00', '2023-05-18 19:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (22, 'Свободное плавание', '2023-05-18 10:00:00', '2023-05-18 11:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (23, 'Обучение плаванию детей', '2023-05-19 17:00:00', '2023-05-19 18:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (24, 'Обучение плаванию детей', '2023-05-19 18:00:00', '2023-05-19 19:00:00', 3, 2, 3, 1, NULL, 30, 0, true);
INSERT INTO public.event VALUES (25, 'Свободное плавание', '2023-05-19 17:00:00', '2023-05-19 18:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (26, 'Свободное плавание', '2023-05-19 18:00:00', '2023-05-19 19:00:00', 4, 2, 3, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (14, 'Свободное плавание', '2023-05-16 10:00:00', '2023-05-16 11:00:00', 4, 2, 3, 1, NULL, 10, 1, true);
INSERT INTO public.event VALUES (11, 'Обучение плаванию детей', '2023-05-16 10:00:00', '2023-05-16 11:00:00', 3, 2, 3, 1, NULL, 30, 1, true);
INSERT INTO public.event VALUES (27, 'Я не буду ЛaИЗАТЬaaadaaaaaa паука', '2023-05-19 18:20:00', '2023-05-19 20:20:00', 1, 1, 1, 1, NULL, 10, 0, true);
INSERT INTO public.event VALUES (16, 'Обучение плаванию детей', '2023-05-17 10:00:00', '2023-05-17 11:00:00', 3, 2, 3, 1, NULL, 30, 1, true);
INSERT INTO public.event VALUES (18, 'Свободное плавание', '2023-05-17 10:00:00', '2023-05-17 11:00:00', 4, 2, 3, 1, NULL, 10, 1, true);


--
-- Data for Name: service; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.service VALUES (1, 'Занятие по аэробике', '1 занятие (студенты/сотрудники)', NULL, 300);
INSERT INTO public.service VALUES (2, 'Спортивные единоборства', '1 занятие (студенты/сотрудники)', NULL, 350);
INSERT INTO public.service VALUES (3, 'Обучение плаванию', '1 занятие (студенты/сотрудники)', NULL, 300);
INSERT INTO public.service VALUES (4, 'Посещение плавательного бассейна', '1 занятие (студенты/сотрудники)', NULL, 150);


--
-- Name: area_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.area_id_seq', 3, true);


--
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_id_seq', 4, true);


--
-- Name: building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_id_seq', 2, true);


--
-- Name: client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_seq', 2, true);


--
-- Name: coach_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.coach_id_seq', 1, false);


--
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_id_seq', 27, true);


--
-- Name: service_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_id_seq', 4, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: area area_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_pkey PRIMARY KEY (id);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- Name: building building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (id);


--
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id);


--
-- Name: coach coach_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_pkey PRIMARY KEY (id);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- Name: service service_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id);


--
-- Name: area area_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.area
    ADD CONSTRAINT area_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.building(id);


--
-- Name: booking booking_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.event(id);


--
-- Name: booking booking_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.client(id);


--
-- Name: coach coach_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.building(id);


--
-- Name: coach coach_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.client(id);


--
-- Name: event event_area_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_area_id_fkey FOREIGN KEY (area_id) REFERENCES public.area(id);


--
-- Name: event event_building_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_building_id_fkey FOREIGN KEY (building_id) REFERENCES public.building(id);


--
-- Name: event event_coach_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_coach_id_fkey FOREIGN KEY (coach_id) REFERENCES public.coach(id);


--
-- Name: event event_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_service_id_fkey FOREIGN KEY (service_id) REFERENCES public.service(id);


--
-- PostgreSQL database dump complete
--
