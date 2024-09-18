--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

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
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: parks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parks (
    gid integer NOT NULL,
    park character varying(80),
    shape_leng numeric,
    shape_area numeric,
    geom public.geometry(MultiPolygon)
);


ALTER TABLE public.parks OWNER TO postgres;

--
-- Name: parks_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parks_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parks_gid_seq OWNER TO postgres;

--
-- Name: parks_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parks_gid_seq OWNED BY public.parks.gid;


--
-- Name: resident_result1; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resident_result1 (
    gid integer,
    type character varying(50),
    askprice double precision,
    bedrooms integer,
    sale_lease character varying(5),
    geom public.geometry(Point),
    buildyear integer
);


ALTER TABLE public.resident_result1 OWNER TO postgres;

--
-- Name: resident_result2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resident_result2 (
    gid integer,
    type character varying(50),
    askprice double precision,
    bedrooms integer,
    sale_lease character varying(5),
    geom public.geometry(Point),
    buildyear integer
);


ALTER TABLE public.resident_result2 OWNER TO postgres;

--
-- Name: residential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.residential (
    gid integer NOT NULL,
    askprice double precision,
    type character varying(50),
    sq_feet integer,
    bedrooms integer,
    lot_featur character varying(15),
    baths double precision,
    stories integer,
    lot_acres double precision,
    subdiv_num integer,
    sale_lease character varying(5),
    address character varying(30),
    priority integer,
    subdivisio integer,
    subdivis_1 integer,
    subdivis_2 character varying(35),
    subdivis_3 integer,
    subdivis_4 numeric,
    geom public.geometry(Point)
);


ALTER TABLE public.residential OWNER TO postgres;

--
-- Name: residential_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.residential_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.residential_gid_seq OWNER TO postgres;

--
-- Name: residential_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.residential_gid_seq OWNED BY public.residential.gid;


--
-- Name: residents_inschool; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.residents_inschool (
    gid integer,
    type character varying(50),
    askprice double precision,
    bedrooms integer,
    sale_lease character varying(5),
    geom public.geometry(Point),
    buildyear integer
);


ALTER TABLE public.residents_inschool OWNER TO postgres;

--
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schools (
    gid integer NOT NULL,
    school character varying(50),
    sch_year character varying(10),
    shape_leng numeric,
    shape_area numeric,
    geom public.geometry(MultiPolygon)
);


ALTER TABLE public.schools OWNER TO postgres;

--
-- Name: schools_gid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schools_gid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schools_gid_seq OWNER TO postgres;

--
-- Name: schools_gid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schools_gid_seq OWNED BY public.schools.gid;


--
-- Name: schools_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schools_result (
    gid integer,
    school character varying(50),
    sch_year character varying(10),
    shape_leng numeric,
    shape_area numeric,
    geom public.geometry(MultiPolygon)
);


ALTER TABLE public.schools_result OWNER TO postgres;

--
-- Name: parks gid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parks ALTER COLUMN gid SET DEFAULT nextval('public.parks_gid_seq'::regclass);


--
-- Name: residential gid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.residential ALTER COLUMN gid SET DEFAULT nextval('public.residential_gid_seq'::regclass);


--
-- Name: schools gid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools ALTER COLUMN gid SET DEFAULT nextval('public.schools_gid_seq'::regclass);


--
-- Name: parks parks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parks
    ADD CONSTRAINT parks_pkey PRIMARY KEY (gid);


--
-- Name: residential residential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.residential
    ADD CONSTRAINT residential_pkey PRIMARY KEY (gid);


--
-- Name: schools schools_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schools
    ADD CONSTRAINT schools_pkey PRIMARY KEY (gid);


--
-- Name: parks_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX parks_geom_idx ON public.parks USING gist (geom);


--
-- Name: residential_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX residential_geom_idx ON public.residential USING gist (geom);


--
-- Name: schools_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schools_geom_idx ON public.schools USING gist (geom);


--
-- PostgreSQL database dump complete
--

