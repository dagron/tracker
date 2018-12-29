--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-1.pgdg90+1)
-- Dumped by pg_dump version 10.5 (Debian 10.5-1.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: migration_versions; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.migration_versions (
    version character varying(255) NOT NULL
);


ALTER TABLE public.migration_versions OWNER TO symfony;

--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.refresh_tokens (
    id integer NOT NULL,
    refresh_token character varying(128) NOT NULL,
    username character varying(255) NOT NULL,
    valid timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.refresh_tokens OWNER TO symfony;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: symfony
--

CREATE SEQUENCE public.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.refresh_tokens_id_seq OWNER TO symfony;

--
-- Name: task_changes; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.task_changes (
    id integer NOT NULL,
    task_id integer,
    state character varying(255) DEFAULT NULL::character varying,
    "position" integer,
    for_date date NOT NULL,
    CONSTRAINT task_changes_state_check CHECK (((state)::text = ANY ((ARRAY['in_progress'::character varying, 'done'::character varying, 'cancelled'::character varying])::text[])))
);


ALTER TABLE public.task_changes OWNER TO symfony;

--
-- Name: COLUMN task_changes.state; Type: COMMENT; Schema: public; Owner: symfony
--

COMMENT ON COLUMN public.task_changes.state IS '(DC2Type:task_change_state)';


--
-- Name: task_changes_id_seq; Type: SEQUENCE; Schema: public; Owner: symfony
--

CREATE SEQUENCE public.task_changes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_changes_id_seq OWNER TO symfony;

--
-- Name: task_timings; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.task_timings (
    id integer NOT NULL,
    task_id integer,
    started_at timestamp(0) without time zone NOT NULL,
    ended_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.task_timings OWNER TO symfony;

--
-- Name: task_timings_id_seq; Type: SEQUENCE; Schema: public; Owner: symfony
--

CREATE SEQUENCE public.task_timings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_timings_id_seq OWNER TO symfony;

--
-- Name: task_transfers; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.task_transfers (
    id integer NOT NULL,
    task_id integer,
    transfer_to date NOT NULL,
    for_date date NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.task_transfers OWNER TO symfony;

--
-- Name: task_transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: symfony
--

CREATE SEQUENCE public.task_transfers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.task_transfers_id_seq OWNER TO symfony;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    user_id integer,
    name text NOT NULL,
    start_date date NOT NULL,
    end_date date,
    updated_at timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    repeat_type character varying(255) DEFAULT NULL::character varying,
    repeat_value text,
    CONSTRAINT tasks_repeat_type_check CHECK (((repeat_type)::text = ANY ((ARRAY['daily'::character varying, 'week'::character varying, 'month'::character varying, 'weekday'::character varying, 'weekend'::character varying, 'custom'::character varying])::text[])))
);


ALTER TABLE public.tasks OWNER TO symfony;

--
-- Name: COLUMN tasks.repeat_type; Type: COMMENT; Schema: public; Owner: symfony
--

COMMENT ON COLUMN public.tasks.repeat_type IS '(DC2Type:task_repeat_type)';


--
-- Name: COLUMN tasks.repeat_value; Type: COMMENT; Schema: public; Owner: symfony
--

COMMENT ON COLUMN public.tasks.repeat_value IS '(DC2Type:array)';


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: symfony
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO symfony;

--
-- Name: user_settings; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.user_settings (
    id integer NOT NULL,
    user_id integer,
    timezone text NOT NULL,
    locale text NOT NULL
);


ALTER TABLE public.user_settings OWNER TO symfony;

--
-- Name: user_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: symfony
--

CREATE SEQUENCE public.user_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_settings_id_seq OWNER TO symfony;

--
-- Name: users; Type: TABLE; Schema: public; Owner: symfony
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    email_canonical character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    roles json NOT NULL,
    enabled boolean NOT NULL,
    last_login timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    password_requested_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO symfony;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: symfony
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO symfony;

--
-- Data for Name: migration_versions; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.migration_versions (version) FROM stdin;
20181207055216
20181211112352
20181226174727
20181227045818
20181227102828
20181229070850
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.refresh_tokens (id, refresh_token, username, valid) FROM stdin;
\.


--
-- Data for Name: task_changes; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.task_changes (id, task_id, state, "position", for_date) FROM stdin;
\.


--
-- Data for Name: task_timings; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.task_timings (id, task_id, started_at, ended_at) FROM stdin;
\.


--
-- Data for Name: task_transfers; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.task_transfers (id, task_id, transfer_to, for_date, created_at) FROM stdin;
1	1	2018-11-04	2018-11-03	2018-12-29 07:14:30
2	1	2018-11-08	2018-11-06	2018-12-29 07:14:30
3	1	2018-11-09	2018-11-06	2018-12-29 07:14:30
4	1	2018-12-07	2018-11-29	2018-12-29 07:14:30
5	5	2018-11-23	2018-11-22	2018-12-29 07:14:30
6	6	2018-11-10	2018-11-07	2018-12-29 07:14:30
7	6	2018-11-08	2018-11-07	2018-12-29 07:14:30
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.tasks (id, user_id, name, start_date, end_date, updated_at, created_at, repeat_type, repeat_value) FROM stdin;
1	1	Exercises	2018-11-01	2018-12-01	2018-12-29 07:14:30	2018-12-29 07:14:30	custom	a:4:{i:0;i:1;i:1;i:1;i:2;i:1;i:3;i:0;}
2	1	Work	2018-10-29	\N	2018-12-29 07:14:30	2018-12-29 07:14:30	weekday	N;
3	1	Cleaning	2018-11-01	\N	2018-12-29 07:14:30	2018-12-29 07:14:30	weekend	N;
4	1	Shopping	2018-11-01	\N	2018-12-29 07:14:30	2018-12-29 07:14:30	week	a:7:{i:0;i:0;i:1;i:0;i:2;i:0;i:3;i:0;i:4;i:0;i:5;i:1;i:6;i:0;}
5	1	Reading	2018-11-19	\N	2018-12-29 07:14:30	2018-12-29 07:14:30	daily	N;
6	1	Single task 1	2018-11-07	\N	2018-12-29 07:14:30	2018-12-29 07:14:30	\N	N;
7	1	Single task 2	2018-12-01	\N	2018-12-29 07:14:30	2018-12-29 07:14:30	\N	N;
\.


--
-- Data for Name: user_settings; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.user_settings (id, user_id, timezone, locale) FROM stdin;
1	1	Europe/Moscow	ru
2	2	Europe/Moscow	ru
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: symfony
--

COPY public.users (id, email, email_canonical, username, password, roles, enabled, last_login, password_requested_at, created_at) FROM stdin;
1	test_user_1@mail.ru	test_user_1@mail.ru	test_user_1	$2y$13$s/NdA90ChL2zPUeBuu1tEe2UXJYB6aQKVRvYdXPUZLc7Lnzs42Vza	[]	t	\N	\N	2018-12-29 07:14:29
2	test_user_2@mail.ru	test_user_2@mail.ru	test_user_2	$2y$13$Oa7/LUFXYo/cUHmq4XPhouMC/eArrdMdNYWUe52CRvk.okCUYg2hG	[]	t	\N	\N	2018-12-29 07:14:30
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: symfony
--

SELECT pg_catalog.setval('public.refresh_tokens_id_seq', 1, false);


--
-- Name: task_changes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: symfony
--

SELECT pg_catalog.setval('public.task_changes_id_seq', 1, false);


--
-- Name: task_timings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: symfony
--

SELECT pg_catalog.setval('public.task_timings_id_seq', 1, false);


--
-- Name: task_transfers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: symfony
--

SELECT pg_catalog.setval('public.task_transfers_id_seq', 7, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: symfony
--

SELECT pg_catalog.setval('public.tasks_id_seq', 7, true);


--
-- Name: user_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: symfony
--

SELECT pg_catalog.setval('public.user_settings_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: symfony
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: migration_versions migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.migration_versions
    ADD CONSTRAINT migration_versions_pkey PRIMARY KEY (version);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: task_changes task_changes_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.task_changes
    ADD CONSTRAINT task_changes_pkey PRIMARY KEY (id);


--
-- Name: task_timings task_timings_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.task_timings
    ADD CONSTRAINT task_timings_pkey PRIMARY KEY (id);


--
-- Name: task_transfers task_transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.task_transfers
    ADD CONSTRAINT task_transfers_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_settings user_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_33246f878db60186; Type: INDEX; Schema: public; Owner: symfony
--

CREATE INDEX idx_33246f878db60186 ON public.task_timings USING btree (task_id);


--
-- Name: idx_3fc192d78db60186; Type: INDEX; Schema: public; Owner: symfony
--

CREATE INDEX idx_3fc192d78db60186 ON public.task_changes USING btree (task_id);


--
-- Name: idx_50586597a76ed395; Type: INDEX; Schema: public; Owner: symfony
--

CREATE INDEX idx_50586597a76ed395 ON public.tasks USING btree (user_id);


--
-- Name: idx_ff00f4498db60186; Type: INDEX; Schema: public; Owner: symfony
--

CREATE INDEX idx_ff00f4498db60186 ON public.task_transfers USING btree (task_id);


--
-- Name: uniq_1483a5e9a0d96fbf; Type: INDEX; Schema: public; Owner: symfony
--

CREATE UNIQUE INDEX uniq_1483a5e9a0d96fbf ON public.users USING btree (email_canonical);


--
-- Name: uniq_1483a5e9e7927c74; Type: INDEX; Schema: public; Owner: symfony
--

CREATE UNIQUE INDEX uniq_1483a5e9e7927c74 ON public.users USING btree (email);


--
-- Name: uniq_3fc192d78db60186792b56ef; Type: INDEX; Schema: public; Owner: symfony
--

CREATE UNIQUE INDEX uniq_3fc192d78db60186792b56ef ON public.task_changes USING btree (task_id, for_date);


--
-- Name: uniq_5c844c5a76ed395; Type: INDEX; Schema: public; Owner: symfony
--

CREATE UNIQUE INDEX uniq_5c844c5a76ed395 ON public.user_settings USING btree (user_id);


--
-- Name: uniq_5c844c5bf396750a76ed395; Type: INDEX; Schema: public; Owner: symfony
--

CREATE UNIQUE INDEX uniq_5c844c5bf396750a76ed395 ON public.user_settings USING btree (id, user_id);


--
-- Name: uniq_9bace7e1c74f2195; Type: INDEX; Schema: public; Owner: symfony
--

CREATE UNIQUE INDEX uniq_9bace7e1c74f2195 ON public.refresh_tokens USING btree (refresh_token);


--
-- Name: task_timings fk_33246f878db60186; Type: FK CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.task_timings
    ADD CONSTRAINT fk_33246f878db60186 FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: task_changes fk_3fc192d78db60186; Type: FK CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.task_changes
    ADD CONSTRAINT fk_3fc192d78db60186 FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- Name: tasks fk_50586597a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_50586597a76ed395 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_settings fk_5c844c5a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT fk_5c844c5a76ed395 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: task_transfers fk_ff00f4498db60186; Type: FK CONSTRAINT; Schema: public; Owner: symfony
--

ALTER TABLE ONLY public.task_transfers
    ADD CONSTRAINT fk_ff00f4498db60186 FOREIGN KEY (task_id) REFERENCES public.tasks(id);


--
-- PostgreSQL database dump complete
--

