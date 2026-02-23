--
-- PostgreSQL database dump
--

\restrict emNKN9hoy80NUpmcru9TgW9LMYpZv3SLfPIAzolYf7v8A4drfaXYnZU8bXck2no

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 16.11 (Debian 16.11-1.pgdg13+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ca_lam; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.ca_lam (
    id integer NOT NULL,
    ten_ca character varying NOT NULL,
    gio_bat_dau character varying NOT NULL,
    gio_ket_thuc character varying NOT NULL,
    so_gio integer,
    la_ca_muon boolean
);


ALTER TABLE public.ca_lam OWNER TO lich_user;

--
-- Name: ca_lam_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.ca_lam_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ca_lam_id_seq OWNER TO lich_user;

--
-- Name: ca_lam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.ca_lam_id_seq OWNED BY public.ca_lam.id;


--
-- Name: chi_nhanh; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.chi_nhanh (
    id integer NOT NULL,
    ma_chi_nhanh character varying NOT NULL,
    ten_chi_nhanh character varying NOT NULL
);


ALTER TABLE public.chi_nhanh OWNER TO lich_user;

--
-- Name: chi_nhanh_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.chi_nhanh_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chi_nhanh_id_seq OWNER TO lich_user;

--
-- Name: chi_nhanh_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.chi_nhanh_id_seq OWNED BY public.chi_nhanh.id;


--
-- Name: lich_chi_tiet; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.lich_chi_tiet (
    id integer NOT NULL,
    lich_tuan_id integer,
    ngay date NOT NULL,
    chi_nhanh_id integer,
    ca_id integer,
    nhan_vien_id integer,
    nhom_hien_thi_id integer
);


ALTER TABLE public.lich_chi_tiet OWNER TO lich_user;

--
-- Name: lich_chi_tiet_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.lich_chi_tiet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lich_chi_tiet_id_seq OWNER TO lich_user;

--
-- Name: lich_chi_tiet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.lich_chi_tiet_id_seq OWNED BY public.lich_chi_tiet.id;


--
-- Name: lich_tuan; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.lich_tuan (
    id integer NOT NULL,
    ngay_bat_dau date NOT NULL,
    ngay_ket_thuc date NOT NULL,
    trang_thai character varying,
    ghi_chu text
);


ALTER TABLE public.lich_tuan OWNER TO lich_user;

--
-- Name: lich_tuan_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.lich_tuan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lich_tuan_id_seq OWNER TO lich_user;

--
-- Name: lich_tuan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.lich_tuan_id_seq OWNED BY public.lich_tuan.id;


--
-- Name: mapping_nhom; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.mapping_nhom (
    id integer NOT NULL,
    chi_nhanh_id integer,
    ca_id integer,
    nhom_hien_thi_id integer
);


ALTER TABLE public.mapping_nhom OWNER TO lich_user;

--
-- Name: mapping_nhom_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.mapping_nhom_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mapping_nhom_id_seq OWNER TO lich_user;

--
-- Name: mapping_nhom_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.mapping_nhom_id_seq OWNED BY public.mapping_nhom.id;


--
-- Name: ngay_nghi; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.ngay_nghi (
    id integer NOT NULL,
    nhan_vien_id integer,
    ngay date NOT NULL,
    trang_thai character varying,
    ghi_chu text
);


ALTER TABLE public.ngay_nghi OWNER TO lich_user;

--
-- Name: ngay_nghi_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.ngay_nghi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ngay_nghi_id_seq OWNER TO lich_user;

--
-- Name: ngay_nghi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.ngay_nghi_id_seq OWNED BY public.ngay_nghi.id;


--
-- Name: nhan_vien; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhan_vien (
    id integer NOT NULL,
    ma_nv character varying NOT NULL,
    ten_nv character varying NOT NULL,
    cap_do character varying,
    muc_uu_tien integer,
    gio_toi_da_tuan integer,
    ghi_chu text
);


ALTER TABLE public.nhan_vien OWNER TO lich_user;

--
-- Name: nhan_vien_ca_tranh; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhan_vien_ca_tranh (
    nhan_vien_id integer NOT NULL,
    ca_id integer NOT NULL
);


ALTER TABLE public.nhan_vien_ca_tranh OWNER TO lich_user;

--
-- Name: nhan_vien_ca_ua_thich; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhan_vien_ca_ua_thich (
    nhan_vien_id integer NOT NULL,
    ca_id integer NOT NULL
);


ALTER TABLE public.nhan_vien_ca_ua_thich OWNER TO lich_user;

--
-- Name: nhan_vien_chi_nhanh; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhan_vien_chi_nhanh (
    nhan_vien_id integer NOT NULL,
    chi_nhanh_id integer NOT NULL
);


ALTER TABLE public.nhan_vien_chi_nhanh OWNER TO lich_user;

--
-- Name: nhan_vien_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.nhan_vien_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nhan_vien_id_seq OWNER TO lich_user;

--
-- Name: nhan_vien_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.nhan_vien_id_seq OWNED BY public.nhan_vien.id;


--
-- Name: nhan_vien_trong_so; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhan_vien_trong_so (
    id integer NOT NULL,
    nhan_vien_id integer,
    trong_so_id integer,
    muc_uu_tien integer
);


ALTER TABLE public.nhan_vien_trong_so OWNER TO lich_user;

--
-- Name: nhan_vien_trong_so_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.nhan_vien_trong_so_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nhan_vien_trong_so_id_seq OWNER TO lich_user;

--
-- Name: nhan_vien_trong_so_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.nhan_vien_trong_so_id_seq OWNED BY public.nhan_vien_trong_so.id;


--
-- Name: nhan_vien_vai_tro; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhan_vien_vai_tro (
    nhan_vien_id integer NOT NULL,
    vai_tro_id integer NOT NULL
);


ALTER TABLE public.nhan_vien_vai_tro OWNER TO lich_user;

--
-- Name: nhom_hien_thi; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhom_hien_thi (
    id integer NOT NULL,
    ten_nhom character varying NOT NULL,
    mau_nen character varying
);


ALTER TABLE public.nhom_hien_thi OWNER TO lich_user;

--
-- Name: nhom_hien_thi_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.nhom_hien_thi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nhom_hien_thi_id_seq OWNER TO lich_user;

--
-- Name: nhom_hien_thi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.nhom_hien_thi_id_seq OWNED BY public.nhom_hien_thi.id;


--
-- Name: nhu_cau_ca; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.nhu_cau_ca (
    id integer NOT NULL,
    ngay date NOT NULL,
    chi_nhanh_id integer,
    ca_id integer,
    so_nguoi_can integer NOT NULL,
    vai_tro_yeu_cau_id integer,
    do_quan_trong integer,
    senior_toi_thieu integer
);


ALTER TABLE public.nhu_cau_ca OWNER TO lich_user;

--
-- Name: nhu_cau_ca_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.nhu_cau_ca_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nhu_cau_ca_id_seq OWNER TO lich_user;

--
-- Name: nhu_cau_ca_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.nhu_cau_ca_id_seq OWNED BY public.nhu_cau_ca.id;


--
-- Name: trong_so_uu_tien; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.trong_so_uu_tien (
    id integer NOT NULL,
    khoa character varying NOT NULL,
    gia_tri integer
);


ALTER TABLE public.trong_so_uu_tien OWNER TO lich_user;

--
-- Name: trong_so_uu_tien_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.trong_so_uu_tien_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.trong_so_uu_tien_id_seq OWNER TO lich_user;

--
-- Name: trong_so_uu_tien_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.trong_so_uu_tien_id_seq OWNED BY public.trong_so_uu_tien.id;


--
-- Name: vai_tro; Type: TABLE; Schema: public; Owner: lich_user
--

CREATE TABLE public.vai_tro (
    id integer NOT NULL,
    ten_vai_tro character varying NOT NULL
);


ALTER TABLE public.vai_tro OWNER TO lich_user;

--
-- Name: vai_tro_id_seq; Type: SEQUENCE; Schema: public; Owner: lich_user
--

CREATE SEQUENCE public.vai_tro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vai_tro_id_seq OWNER TO lich_user;

--
-- Name: vai_tro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lich_user
--

ALTER SEQUENCE public.vai_tro_id_seq OWNED BY public.vai_tro.id;


--
-- Name: ca_lam id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.ca_lam ALTER COLUMN id SET DEFAULT nextval('public.ca_lam_id_seq'::regclass);


--
-- Name: chi_nhanh id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.chi_nhanh ALTER COLUMN id SET DEFAULT nextval('public.chi_nhanh_id_seq'::regclass);


--
-- Name: lich_chi_tiet id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_chi_tiet ALTER COLUMN id SET DEFAULT nextval('public.lich_chi_tiet_id_seq'::regclass);


--
-- Name: lich_tuan id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_tuan ALTER COLUMN id SET DEFAULT nextval('public.lich_tuan_id_seq'::regclass);


--
-- Name: mapping_nhom id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.mapping_nhom ALTER COLUMN id SET DEFAULT nextval('public.mapping_nhom_id_seq'::regclass);


--
-- Name: ngay_nghi id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.ngay_nghi ALTER COLUMN id SET DEFAULT nextval('public.ngay_nghi_id_seq'::regclass);


--
-- Name: nhan_vien id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien ALTER COLUMN id SET DEFAULT nextval('public.nhan_vien_id_seq'::regclass);


--
-- Name: nhan_vien_trong_so id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_trong_so ALTER COLUMN id SET DEFAULT nextval('public.nhan_vien_trong_so_id_seq'::regclass);


--
-- Name: nhom_hien_thi id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhom_hien_thi ALTER COLUMN id SET DEFAULT nextval('public.nhom_hien_thi_id_seq'::regclass);


--
-- Name: nhu_cau_ca id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhu_cau_ca ALTER COLUMN id SET DEFAULT nextval('public.nhu_cau_ca_id_seq'::regclass);


--
-- Name: trong_so_uu_tien id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.trong_so_uu_tien ALTER COLUMN id SET DEFAULT nextval('public.trong_so_uu_tien_id_seq'::regclass);


--
-- Name: vai_tro id; Type: DEFAULT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.vai_tro ALTER COLUMN id SET DEFAULT nextval('public.vai_tro_id_seq'::regclass);


--
-- Data for Name: ca_lam; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.ca_lam (id, ten_ca, gio_bat_dau, gio_ket_thuc, so_gio, la_ca_muon) FROM stdin;
1	8h-19h	8h	19h	11	f
2	8h30-19h30	8h30	19h30	11	f
3	9h-20h	9h	20h	11	t
4	10h-21h	10h	21h	11	t
5	8h30-19h	8h30	19h	10	f
\.


--
-- Data for Name: chi_nhanh; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.chi_nhanh (id, ma_chi_nhanh, ten_chi_nhanh) FROM stdin;
1	326	326TTV
2	197	197LT5
3	796	796ADV
\.


--
-- Data for Name: lich_chi_tiet; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.lich_chi_tiet (id, lich_tuan_id, ngay, chi_nhanh_id, ca_id, nhan_vien_id, nhom_hien_thi_id) FROM stdin;
1	1	2026-01-24	1	1	3	1
2	1	2026-01-24	1	3	1	1
3	1	2026-01-24	2	3	2	2
4	1	2026-01-24	3	3	4	3
5	1	2026-01-25	1	1	3	1
6	1	2026-01-25	1	3	1	1
7	1	2026-01-25	2	3	2	2
8	1	2026-01-25	3	3	4	3
9	1	2026-01-24	\N	3	10	4
10	1	2026-01-25	\N	3	5	4
11	1	2026-01-26	\N	3	2	4
12	1	2026-01-27	\N	3	3	4
13	1	2026-01-28	\N	3	1	4
14	1	2026-01-29	\N	3	2	4
15	1	2026-01-30	\N	3	1	4
16	2	2026-01-19	1	1	3	1
17	2	2026-01-19	1	3	6	1
18	2	2026-01-19	2	3	2	2
19	2	2026-01-19	3	3	4	3
20	2	2026-01-20	1	1	3	1
21	2	2026-01-20	1	3	1	1
22	2	2026-01-20	2	3	2	2
23	2	2026-01-20	3	3	4	3
24	2	2026-01-21	1	1	3	1
25	2	2026-01-21	1	3	1	1
26	2	2026-01-21	2	3	2	2
27	2	2026-01-21	3	3	4	3
28	2	2026-01-22	1	1	3	1
29	2	2026-01-22	1	3	1	1
30	2	2026-01-22	2	3	2	2
31	2	2026-01-22	3	3	4	3
32	2	2026-01-23	1	1	3	1
33	2	2026-01-23	1	3	1	1
34	2	2026-01-23	2	3	2	2
35	2	2026-01-23	3	3	5	3
36	2	2026-01-24	1	1	3	1
37	2	2026-01-24	1	3	8	1
38	2	2026-01-24	2	3	6	2
39	2	2026-01-24	3	3	11	3
40	2	2026-01-25	1	1	4	1
41	2	2026-01-25	1	3	1	1
42	2	2026-01-25	2	3	2	2
43	2	2026-01-25	3	3	5	3
44	2	2026-01-19	\N	3	1	4
45	2	2026-01-20	\N	3	5	4
46	2	2026-01-21	\N	3	11	4
47	2	2026-01-22	\N	3	9	4
48	2	2026-01-23	\N	3	4	4
49	2	2026-01-24	\N	3	10	4
50	2	2026-01-25	\N	3	7	4
51	3	2026-01-19	1	1	3	1
52	3	2026-01-19	1	3	1	1
53	3	2026-01-19	2	3	2	2
54	3	2026-01-19	3	3	4	3
55	3	2026-01-20	1	1	3	1
56	3	2026-01-20	1	3	5	1
57	3	2026-01-20	2	3	2	2
58	3	2026-01-20	3	3	4	3
59	3	2026-01-21	1	1	3	1
60	3	2026-01-21	1	3	1	1
61	3	2026-01-21	2	3	2	2
62	3	2026-01-21	3	3	4	3
63	3	2026-01-22	1	1	3	1
64	3	2026-01-22	1	3	1	1
65	3	2026-01-22	2	3	2	2
66	3	2026-01-22	3	3	4	3
67	3	2026-01-23	1	1	3	1
68	3	2026-01-23	1	3	1	1
69	3	2026-01-23	2	3	2	2
70	3	2026-01-23	3	3	4	3
71	3	2026-01-24	1	1	3	1
72	3	2026-01-24	1	3	10	1
73	3	2026-01-24	2	3	8	2
74	3	2026-01-24	3	3	7	3
75	3	2026-01-25	1	1	9	1
76	3	2026-01-25	1	3	1	1
77	3	2026-01-25	2	3	2	2
78	3	2026-01-25	3	3	11	3
79	3	2026-01-19	\N	3	11	4
80	3	2026-01-20	\N	3	1	4
81	3	2026-01-21	\N	3	10	4
82	3	2026-01-22	\N	3	7	4
83	3	2026-01-23	\N	3	9	4
84	3	2026-01-24	\N	3	6	4
85	3	2026-01-25	\N	3	4	4
86	4	2026-01-19	1	1	5	1
87	4	2026-01-19	1	3	4	1
88	4	2026-01-19	2	3	2	2
89	4	2026-01-19	3	3	11	3
90	4	2026-01-20	1	1	3	1
91	4	2026-01-20	1	3	1	1
92	4	2026-01-20	2	3	2	2
93	4	2026-01-20	3	3	4	3
94	4	2026-01-21	1	1	3	1
95	4	2026-01-21	1	3	1	1
96	4	2026-01-21	2	3	4	2
97	4	2026-01-21	3	3	11	3
98	4	2026-01-22	1	1	3	1
99	4	2026-01-22	1	3	1	1
100	4	2026-01-22	2	3	2	2
101	4	2026-01-22	3	3	11	3
102	4	2026-01-23	1	1	3	1
103	4	2026-01-23	1	3	1	1
104	4	2026-01-23	2	3	4	2
105	4	2026-01-23	3	3	11	3
106	4	2026-01-24	1	1	3	1
107	4	2026-01-24	1	3	1	1
108	4	2026-01-24	2	3	2	2
109	4	2026-01-24	3	3	11	3
110	4	2026-01-25	1	1	3	1
111	4	2026-01-25	1	3	6	1
112	4	2026-01-25	2	3	2	2
113	4	2026-01-25	3	3	4	3
114	4	2026-01-19	\N	3	1	4
115	4	2026-01-20	\N	3	11	4
116	4	2026-01-21	\N	3	2	4
117	4	2026-01-22	\N	3	4	4
118	4	2026-01-23	\N	3	6	4
119	4	2026-01-24	\N	3	10	4
120	4	2026-01-25	\N	3	8	4
121	5	2026-01-19	1	1	3	1
122	5	2026-01-19	1	3	1	1
123	5	2026-01-19	2	3	2	2
124	5	2026-01-19	3	3	11	3
125	5	2026-01-20	1	1	3	1
126	5	2026-01-20	1	3	1	1
127	5	2026-01-20	2	3	4	2
128	5	2026-01-20	3	3	11	3
129	5	2026-01-21	1	1	3	1
130	5	2026-01-21	1	3	4	1
131	5	2026-01-21	2	3	2	2
132	5	2026-01-21	3	3	11	3
133	5	2026-01-22	1	1	3	1
134	5	2026-01-22	1	3	1	1
135	5	2026-01-22	2	3	4	2
136	5	2026-01-22	3	3	11	3
137	5	2026-01-23	1	1	3	1
138	5	2026-01-23	1	3	1	1
139	5	2026-01-23	2	3	2	2
140	5	2026-01-23	3	3	4	3
141	5	2026-01-24	1	1	10	1
142	5	2026-01-24	1	3	1	1
143	5	2026-01-24	2	3	2	2
144	5	2026-01-24	3	3	11	3
145	5	2026-01-25	1	1	3	1
146	5	2026-01-25	1	3	1	1
147	5	2026-01-25	2	3	2	2
148	5	2026-01-25	3	3	4	3
149	5	2026-01-19	\N	3	4	4
150	5	2026-01-20	\N	3	10	4
151	5	2026-01-21	\N	3	6	4
152	5	2026-01-22	\N	3	2	4
153	5	2026-01-23	\N	3	11	4
154	5	2026-01-24	\N	3	7	4
155	5	2026-01-25	\N	3	5	4
156	6	2026-01-19	1	1	3	1
157	6	2026-01-19	1	3	4	1
158	6	2026-01-19	2	3	2	2
159	6	2026-01-19	3	3	11	3
160	6	2026-01-20	1	1	3	1
161	6	2026-01-20	1	3	4	1
162	6	2026-01-20	2	3	2	2
163	6	2026-01-20	3	3	11	3
164	6	2026-01-21	1	1	3	1
165	6	2026-01-21	1	3	1	1
166	6	2026-01-21	2	3	2	2
167	6	2026-01-21	3	3	4	3
168	6	2026-01-22	1	1	3	1
169	6	2026-01-22	1	3	1	1
170	6	2026-01-22	2	3	2	2
171	6	2026-01-22	3	3	11	3
172	6	2026-01-23	1	1	3	1
173	6	2026-01-23	1	3	1	1
174	6	2026-01-23	2	3	4	2
175	6	2026-01-23	3	3	11	3
176	6	2026-01-24	1	1	3	1
177	6	2026-01-24	1	3	1	1
178	6	2026-01-24	2	3	2	2
179	6	2026-01-24	3	3	4	3
180	6	2026-01-25	1	1	10	1
181	6	2026-01-25	1	3	1	1
182	6	2026-01-25	2	3	4	2
183	6	2026-01-25	3	3	11	3
184	6	2026-01-19	\N	3	10	4
185	6	2026-01-20	\N	3	1	4
186	6	2026-01-21	\N	3	11	4
187	6	2026-01-22	\N	3	8	4
188	6	2026-01-23	\N	3	2	4
189	6	2026-01-24	\N	3	9	4
190	6	2026-01-25	\N	3	7	4
191	7	2026-01-19	1	1	3	1
192	7	2026-01-19	1	3	4	1
193	7	2026-01-19	2	3	2	2
194	7	2026-01-19	3	3	11	3
195	7	2026-01-20	1	1	3	1
196	7	2026-01-20	1	3	1	1
197	7	2026-01-20	2	3	2	2
198	7	2026-01-20	3	3	4	3
199	7	2026-01-21	1	1	3	1
200	7	2026-01-21	1	3	1	1
201	7	2026-01-21	2	3	4	2
202	7	2026-01-21	3	3	11	3
203	7	2026-01-22	1	1	3	1
204	7	2026-01-22	1	3	1	1
205	7	2026-01-22	2	3	4	2
206	7	2026-01-22	3	3	11	3
207	7	2026-01-23	1	1	3	1
208	7	2026-01-23	1	3	1	1
209	7	2026-01-23	2	3	2	2
210	7	2026-01-23	3	3	11	3
211	7	2026-01-24	1	1	3	1
212	7	2026-01-24	1	3	1	1
213	7	2026-01-24	2	3	2	2
214	7	2026-01-24	3	3	4	3
215	7	2026-01-25	1	1	9	1
216	7	2026-01-25	1	3	4	1
217	7	2026-01-25	2	3	2	2
218	7	2026-01-25	3	3	11	3
219	7	2026-01-19	\N	3	1	4
220	7	2026-01-20	\N	3	11	4
221	7	2026-01-21	\N	3	2	4
222	7	2026-01-22	\N	3	9	4
223	7	2026-01-23	\N	3	6	4
224	7	2026-01-24	\N	3	5	4
225	7	2026-01-25	\N	3	8	4
226	8	2026-01-26	\N	3	1	4
227	8	2026-01-27	\N	3	4	4
228	8	2026-01-28	\N	3	3	4
229	8	2026-01-29	\N	3	2	4
230	8	2026-01-30	\N	3	4	4
231	8	2026-01-31	\N	3	1	4
232	8	2026-02-01	\N	3	3	4
233	9	2026-01-19	1	1	3	1
234	9	2026-01-19	1	3	4	1
235	9	2026-01-19	2	3	2	2
236	9	2026-01-19	3	3	11	3
237	9	2026-01-20	1	1	3	1
238	9	2026-01-20	1	3	1	1
239	9	2026-01-20	2	3	2	2
240	9	2026-01-20	3	3	4	3
241	9	2026-01-21	1	1	7	1
242	9	2026-01-21	1	3	1	1
243	9	2026-01-21	2	3	2	2
244	9	2026-01-21	3	3	4	3
245	9	2026-01-22	1	1	3	1
246	9	2026-01-22	1	3	1	1
247	9	2026-01-22	2	3	2	2
248	9	2026-01-22	3	3	11	3
249	9	2026-01-23	1	1	3	1
250	9	2026-01-23	1	3	1	1
251	9	2026-01-23	2	3	2	2
252	9	2026-01-23	3	3	11	3
253	9	2026-01-24	1	1	3	1
254	9	2026-01-24	1	3	6	1
255	9	2026-01-24	2	3	4	2
256	9	2026-01-24	3	3	11	3
257	9	2026-01-25	1	1	3	1
258	9	2026-01-25	1	3	1	1
259	9	2026-01-25	2	3	4	2
260	9	2026-01-25	3	3	11	3
261	9	2026-01-19	\N	3	1	4
262	9	2026-01-20	\N	3	11	4
263	9	2026-01-21	\N	3	5	4
264	9	2026-01-22	\N	3	6	4
265	9	2026-01-23	\N	3	4	4
266	9	2026-01-24	\N	3	2	4
267	9	2026-01-25	\N	3	7	4
268	10	2026-01-26	\N	3	3	4
269	10	2026-01-27	\N	3	1	4
270	10	2026-01-28	\N	3	4	4
271	10	2026-01-29	\N	3	2	4
272	10	2026-01-30	\N	3	3	4
273	10	2026-01-31	\N	3	4	4
274	10	2026-02-01	\N	3	1	4
275	11	2026-02-02	\N	3	3	4
276	11	2026-02-03	\N	3	3	4
277	11	2026-02-04	\N	3	2	4
278	11	2026-02-05	\N	3	2	4
279	11	2026-02-06	\N	3	1	4
280	11	2026-02-07	\N	3	1	4
281	11	2026-02-08	\N	3	4	4
282	12	2026-01-12	\N	3	3	4
283	12	2026-01-13	\N	3	2	4
284	12	2026-01-14	\N	3	1	4
285	12	2026-01-15	\N	3	4	4
286	12	2026-01-16	\N	3	3	4
287	12	2026-01-17	\N	3	1	4
288	12	2026-01-18	\N	3	4	4
289	13	2026-01-26	\N	3	2	4
290	13	2026-01-27	\N	3	2	4
291	13	2026-01-28	\N	3	4	4
292	13	2026-01-29	\N	3	1	4
293	13	2026-01-30	\N	3	3	4
294	13	2026-01-31	\N	3	4	4
295	13	2026-02-01	\N	3	1	4
296	14	2026-01-26	\N	3	2	4
297	14	2026-01-27	\N	3	4	4
298	14	2026-01-28	\N	3	2	4
299	14	2026-01-29	\N	3	1	4
300	14	2026-01-30	\N	3	3	4
301	14	2026-01-31	\N	3	4	4
302	14	2026-02-01	\N	3	1	4
303	15	2026-01-26	\N	3	2	4
304	15	2026-01-27	\N	3	2	4
305	15	2026-01-28	\N	3	4	4
306	15	2026-01-29	\N	3	1	4
307	15	2026-01-30	\N	3	3	4
308	15	2026-01-31	\N	3	4	4
309	15	2026-02-01	\N	3	1	4
310	16	2026-01-26	\N	3	2	4
311	16	2026-01-27	\N	3	3	4
312	16	2026-01-28	\N	3	3	4
313	16	2026-01-29	\N	3	2	4
314	16	2026-01-30	\N	3	1	4
315	16	2026-01-31	\N	3	1	4
316	16	2026-02-01	\N	3	4	4
317	17	2026-01-19	1	1	3	1
318	17	2026-01-19	1	3	4	1
319	17	2026-01-19	2	3	2	2
320	17	2026-01-19	3	3	11	3
321	17	2026-01-20	1	1	3	1
322	17	2026-01-20	1	3	1	1
323	17	2026-01-20	2	3	4	2
324	17	2026-01-20	3	3	11	3
325	17	2026-01-21	1	1	9	1
326	17	2026-01-21	1	3	1	1
327	17	2026-01-21	2	3	2	2
328	17	2026-01-21	3	3	11	3
329	17	2026-01-22	1	1	3	1
330	17	2026-01-22	1	3	1	1
331	17	2026-01-22	2	3	2	2
332	17	2026-01-22	3	3	4	3
333	17	2026-01-23	1	1	3	1
334	17	2026-01-23	1	3	4	1
335	17	2026-01-23	2	3	2	2
336	17	2026-01-23	3	3	11	3
337	17	2026-01-24	1	1	3	1
338	17	2026-01-24	1	3	1	1
339	17	2026-01-24	2	3	2	2
340	17	2026-01-24	3	3	11	3
341	17	2026-01-25	1	1	3	1
342	17	2026-01-25	1	3	1	1
343	17	2026-01-25	2	3	9	2
344	17	2026-01-25	3	3	4	3
345	17	2026-01-19	\N	3	1	4
346	17	2026-01-20	\N	3	2	4
347	17	2026-01-21	\N	3	4	4
348	17	2026-01-22	\N	3	11	4
349	17	2026-01-23	\N	3	5	4
350	17	2026-01-24	\N	3	6	4
351	17	2026-01-25	\N	3	7	4
352	18	2026-01-26	1	1	3	1
353	18	2026-01-26	1	3	4	1
354	18	2026-01-26	2	3	2	2
355	18	2026-01-26	3	3	11	3
356	18	2026-01-27	1	1	3	1
357	18	2026-01-27	1	3	1	1
358	18	2026-01-27	2	3	4	2
359	18	2026-01-27	3	3	11	3
360	18	2026-01-28	1	1	3	1
361	18	2026-01-28	1	3	1	1
362	18	2026-01-28	2	3	2	2
363	18	2026-01-28	3	3	4	3
364	18	2026-01-29	1	1	3	1
365	18	2026-01-29	1	3	1	1
366	18	2026-01-29	2	3	2	2
367	18	2026-01-29	3	3	4	3
368	18	2026-01-30	1	1	3	1
369	18	2026-01-30	1	3	1	1
370	18	2026-01-30	2	3	2	2
371	18	2026-01-30	3	3	11	3
372	18	2026-01-31	1	1	3	1
373	18	2026-01-31	1	3	6	1
374	18	2026-01-31	2	3	5	2
375	18	2026-01-31	3	3	11	3
376	18	2026-02-01	1	1	4	1
377	18	2026-02-01	1	3	1	1
378	18	2026-02-01	2	3	2	2
379	18	2026-02-01	3	3	11	3
380	18	2026-01-26	\N	3	1	4
381	18	2026-01-27	\N	3	2	4
382	18	2026-01-28	\N	3	11	4
383	18	2026-01-29	\N	3	6	4
384	18	2026-01-30	\N	3	4	4
385	18	2026-01-31	\N	3	9	4
386	18	2026-02-01	\N	3	8	4
387	19	2026-02-02	1	1	3	1
388	19	2026-02-02	1	3	4	1
389	19	2026-02-02	2	3	2	2
390	19	2026-02-02	3	3	11	3
391	19	2026-02-03	1	1	3	1
392	19	2026-02-03	1	3	1	1
393	19	2026-02-03	2	3	2	2
394	19	2026-02-03	3	3	4	3
395	19	2026-02-04	1	1	3	1
396	19	2026-02-04	1	3	1	1
397	19	2026-02-04	2	3	4	2
398	19	2026-02-04	3	3	11	3
399	19	2026-02-05	1	1	3	1
400	19	2026-02-05	1	3	1	1
401	19	2026-02-05	2	3	4	2
402	19	2026-02-05	3	3	11	3
403	19	2026-02-06	1	1	3	1
404	19	2026-02-06	1	3	1	1
405	19	2026-02-06	2	3	2	2
406	19	2026-02-06	3	3	11	3
407	19	2026-02-07	1	1	3	1
408	19	2026-02-07	1	3	1	1
409	19	2026-02-07	2	3	2	2
410	19	2026-02-07	3	3	4	3
411	19	2026-02-08	1	1	9	1
412	19	2026-02-08	1	3	8	1
413	19	2026-02-08	2	3	2	2
414	19	2026-02-08	3	3	11	3
415	19	2026-02-02	\N	3	1	4
416	19	2026-02-03	\N	3	11	4
417	19	2026-02-04	\N	3	2	4
418	19	2026-02-05	\N	3	9	4
419	19	2026-02-06	\N	3	5	4
420	19	2026-02-07	\N	3	7	4
421	19	2026-02-08	\N	3	4	4
422	20	2026-02-23	1	1	6	1
423	20	2026-02-23	1	3	4	1
424	20	2026-02-23	2	3	2	2
425	20	2026-02-23	3	3	11	3
426	20	2026-02-24	1	1	3	1
427	20	2026-02-24	1	3	9	1
428	20	2026-02-24	2	3	4	2
429	20	2026-02-24	3	3	11	3
430	20	2026-02-25	1	1	3	1
431	20	2026-02-25	1	3	1	1
432	20	2026-02-25	2	3	2	2
433	20	2026-02-25	3	3	11	3
434	20	2026-02-26	1	1	3	1
435	20	2026-02-26	1	3	1	1
436	20	2026-02-26	2	3	4	2
437	20	2026-02-26	3	3	11	3
438	20	2026-02-27	1	1	3	1
439	20	2026-02-27	1	3	1	1
440	20	2026-02-27	2	3	2	2
441	20	2026-02-27	3	3	4	3
442	20	2026-02-28	1	1	3	1
443	20	2026-02-28	1	3	1	1
444	20	2026-02-28	2	3	2	2
445	20	2026-02-28	3	3	4	3
446	20	2026-03-01	1	1	3	1
447	20	2026-03-01	1	3	1	1
448	20	2026-03-01	2	3	2	2
449	20	2026-03-01	3	3	11	3
450	20	2026-02-23	\N	3	5	4
451	20	2026-02-24	\N	3	1	4
452	20	2026-02-25	\N	3	4	4
453	20	2026-02-26	\N	3	2	4
454	20	2026-02-27	\N	3	11	4
455	20	2026-02-28	\N	3	9	4
456	20	2026-03-01	\N	3	8	4
457	21	2026-03-09	1	1	3	1
458	21	2026-03-09	1	3	7	1
459	21	2026-03-09	2	3	4	2
460	21	2026-03-09	3	3	11	3
461	21	2026-03-10	1	1	3	1
462	21	2026-03-10	1	3	1	1
463	21	2026-03-10	2	3	2	2
464	21	2026-03-10	3	3	4	3
465	21	2026-03-11	1	1	3	1
466	21	2026-03-11	1	3	1	1
467	21	2026-03-11	2	3	4	2
468	21	2026-03-11	3	3	11	3
469	21	2026-03-12	1	1	3	1
470	21	2026-03-12	1	3	1	1
471	21	2026-03-12	2	3	2	2
472	21	2026-03-12	3	3	11	3
473	21	2026-03-13	1	1	3	1
474	21	2026-03-13	1	3	1	1
475	21	2026-03-13	2	3	2	2
476	21	2026-03-13	3	3	11	3
477	21	2026-03-14	1	1	4	1
478	21	2026-03-14	1	3	1	1
479	21	2026-03-14	2	3	2	2
480	21	2026-03-14	3	3	11	3
481	21	2026-03-15	1	1	3	1
482	21	2026-03-15	1	3	5	1
483	21	2026-03-15	2	3	2	2
484	21	2026-03-15	3	3	4	3
485	21	2026-03-09	\N	3	1	4
486	21	2026-03-10	\N	3	11	4
487	21	2026-03-11	\N	3	2	4
488	21	2026-03-12	\N	3	4	4
489	21	2026-03-13	\N	3	8	4
490	21	2026-03-14	\N	3	6	4
491	21	2026-03-15	\N	3	9	4
492	22	2026-03-23	1	1	3	1
493	22	2026-03-23	1	3	4	1
494	22	2026-03-23	2	3	2	2
495	22	2026-03-23	3	3	11	3
496	22	2026-03-24	1	1	3	1
497	22	2026-03-24	1	3	1	1
498	22	2026-03-24	2	3	2	2
499	22	2026-03-24	3	3	11	3
500	22	2026-03-25	1	1	7	1
501	22	2026-03-25	1	3	1	1
502	22	2026-03-25	2	3	4	2
503	22	2026-03-25	3	3	11	3
504	22	2026-03-26	1	1	3	1
505	22	2026-03-26	1	3	1	1
506	22	2026-03-26	2	3	4	2
507	22	2026-03-26	3	3	11	3
508	22	2026-03-27	1	1	3	1
509	22	2026-03-27	1	3	1	1
510	22	2026-03-27	2	3	2	2
511	22	2026-03-27	3	3	4	3
512	22	2026-03-28	1	1	3	1
513	22	2026-03-28	1	3	5	1
514	22	2026-03-28	2	3	2	2
515	22	2026-03-28	3	3	4	3
516	22	2026-03-29	1	1	3	1
517	22	2026-03-29	1	3	1	1
518	22	2026-03-29	2	3	2	2
519	22	2026-03-29	3	3	11	3
520	22	2026-03-23	\N	3	1	4
521	22	2026-03-24	\N	3	4	4
522	22	2026-03-25	\N	3	2	4
523	22	2026-03-26	\N	3	5	4
524	22	2026-03-27	\N	3	11	4
525	22	2026-03-28	\N	3	8	4
526	22	2026-03-29	\N	3	9	4
527	23	2026-03-23	1	1	3	1
528	23	2026-03-23	1	3	1	1
529	23	2026-03-23	2	3	2	2
530	23	2026-03-23	3	3	11	3
531	23	2026-03-24	1	1	3	1
532	23	2026-03-24	1	3	4	1
533	23	2026-03-24	2	3	2	2
534	23	2026-03-24	3	3	11	3
535	23	2026-03-25	1	1	3	1
536	23	2026-03-25	1	3	1	1
537	23	2026-03-25	2	3	2	2
538	23	2026-03-25	3	3	11	3
539	23	2026-03-26	1	1	3	1
540	23	2026-03-26	1	3	1	1
541	23	2026-03-26	2	3	2	2
542	23	2026-03-26	3	3	4	3
543	23	2026-03-27	1	1	9	1
544	23	2026-03-27	1	3	1	1
545	23	2026-03-27	2	3	4	2
546	23	2026-03-27	3	3	11	3
547	23	2026-03-28	1	1	3	1
548	23	2026-03-28	1	3	7	1
549	23	2026-03-28	2	3	4	2
550	23	2026-03-28	3	3	11	3
551	23	2026-03-29	1	1	3	1
552	23	2026-03-29	1	3	1	1
553	23	2026-03-29	2	3	2	2
554	23	2026-03-29	3	3	4	3
555	23	2026-03-23	\N	3	7	4
556	23	2026-03-24	\N	3	6	4
557	23	2026-03-25	\N	3	4	4
558	23	2026-03-26	\N	3	11	4
559	23	2026-03-27	\N	3	2	4
560	23	2026-03-28	\N	3	1	4
561	23	2026-03-29	\N	3	5	4
562	24	2026-03-30	1	1	3	1
563	24	2026-03-30	1	3	4	1
564	24	2026-03-30	2	3	2	2
565	24	2026-03-30	3	3	11	3
566	24	2026-03-31	1	1	3	1
567	24	2026-03-31	1	3	1	1
568	24	2026-03-31	2	3	4	2
569	24	2026-03-31	3	3	11	3
571	24	2026-04-01	1	3	1	1
572	24	2026-04-01	2	3	2	2
573	24	2026-04-01	3	3	11	3
574	24	2026-04-02	1	1	3	1
576	24	2026-04-02	2	3	2	2
577	24	2026-04-02	3	3	4	3
578	24	2026-04-03	1	1	3	1
580	24	2026-04-03	2	3	2	2
581	24	2026-04-03	3	3	11	3
582	24	2026-04-04	1	1	4	1
583	24	2026-04-04	1	3	9	1
584	24	2026-04-04	2	3	6	2
585	24	2026-04-04	3	3	11	3
586	24	2026-04-05	1	1	3	1
587	24	2026-04-05	1	3	1	1
588	24	2026-04-05	2	3	2	2
589	24	2026-04-05	3	3	4	3
590	24	2026-03-30	\N	3	1	4
591	24	2026-03-31	\N	3	2	4
592	24	2026-04-01	\N	3	4	4
593	24	2026-04-02	\N	3	11	4
594	24	2026-04-03	\N	3	8	4
595	24	2026-04-04	\N	3	10	4
596	24	2026-04-05	\N	3	6	4
570	24	2026-04-02	1	1	3	1
575	24	2026-04-01	1	3	1	1
579	24	2026-04-02	1	3	1	1
597	25	2026-03-30	1	1	3	1
598	25	2026-03-30	1	3	4	1
599	25	2026-03-30	2	3	2	2
600	25	2026-03-30	3	3	11	3
601	25	2026-03-31	1	1	3	1
602	25	2026-03-31	1	3	1	1
603	25	2026-03-31	2	3	4	2
604	25	2026-03-31	3	3	11	3
605	25	2026-04-01	1	1	3	1
606	25	2026-04-01	1	3	1	1
607	25	2026-04-01	2	3	2	2
608	25	2026-04-01	3	3	4	3
609	25	2026-04-02	1	1	3	1
610	25	2026-04-02	1	3	1	1
611	25	2026-04-02	2	3	4	2
612	25	2026-04-02	3	3	11	3
613	25	2026-04-03	1	1	3	1
614	25	2026-04-03	1	3	1	1
615	25	2026-04-03	2	3	2	2
616	25	2026-04-03	3	3	11	3
617	25	2026-04-04	1	1	3	1
618	25	2026-04-04	1	3	6	1
619	25	2026-04-04	2	3	2	2
620	25	2026-04-04	3	3	5	3
621	25	2026-04-05	1	1	4	1
622	25	2026-04-05	1	3	1	1
623	25	2026-04-05	2	3	2	2
624	25	2026-04-05	3	3	11	3
625	25	2026-03-30	\N	3	1	4
626	25	2026-03-31	\N	3	2	4
627	25	2026-04-01	\N	3	11	4
628	25	2026-04-02	\N	3	9	4
629	25	2026-04-03	\N	3	4	4
630	25	2026-04-04	\N	3	8	4
631	25	2026-04-05	\N	3	7	4
632	26	2026-03-23	1	1	3	1
633	26	2026-03-23	1	3	1	1
634	26	2026-03-23	2	3	4	2
635	26	2026-03-23	3	3	11	3
636	26	2026-03-24	1	1	10	1
637	26	2026-03-24	1	3	4	1
638	26	2026-03-24	2	3	2	2
639	26	2026-03-24	3	3	11	3
640	26	2026-03-25	1	1	3	1
641	26	2026-03-25	1	3	1	1
642	26	2026-03-25	2	3	2	2
643	26	2026-03-25	3	3	4	3
644	26	2026-03-26	1	1	3	1
645	26	2026-03-26	1	3	1	1
646	26	2026-03-26	2	3	2	2
647	26	2026-03-26	3	3	11	3
648	26	2026-03-27	1	1	3	1
649	26	2026-03-27	1	3	4	1
650	26	2026-03-27	2	3	2	2
651	26	2026-03-27	3	3	11	3
652	26	2026-03-28	1	1	3	1
654	26	2026-03-28	2	3	2	2
655	26	2026-03-28	3	3	4	3
656	26	2026-03-29	1	1	3	1
657	26	2026-03-29	1	3	1	1
658	26	2026-03-29	2	3	2	2
659	26	2026-03-29	3	3	11	3
660	26	2026-03-23	\N	3	5	4
661	26	2026-03-24	\N	3	1	4
662	26	2026-03-25	\N	3	10	4
663	26	2026-03-26	\N	3	4	4
664	26	2026-03-27	\N	3	6	4
665	26	2026-03-28	\N	3	11	4
666	26	2026-03-29	\N	3	9	4
653	26	2026-03-27	1	3	1	1
667	27	2026-03-09	1	1	3	1
668	27	2026-03-09	1	3	4	1
669	27	2026-03-09	2	3	2	2
670	27	2026-03-09	3	3	11	3
671	27	2026-03-10	1	1	3	1
672	27	2026-03-10	1	3	4	1
673	27	2026-03-10	2	3	2	2
674	27	2026-03-10	3	3	11	3
675	27	2026-03-11	1	1	7	1
676	27	2026-03-11	1	3	1	1
677	27	2026-03-11	2	3	4	2
678	27	2026-03-11	3	3	11	3
679	27	2026-03-12	1	1	3	1
680	27	2026-03-12	1	3	1	1
681	27	2026-03-12	2	3	2	2
682	27	2026-03-12	3	3	11	3
683	27	2026-03-13	1	1	3	1
684	27	2026-03-13	1	3	1	1
685	27	2026-03-13	2	3	2	2
686	27	2026-03-13	3	3	4	3
687	27	2026-03-14	1	1	3	1
688	27	2026-03-14	1	3	1	1
689	27	2026-03-14	2	3	2	2
690	27	2026-03-14	3	3	11	3
691	27	2026-03-15	1	1	3	1
692	27	2026-03-15	1	3	1	1
694	27	2026-03-15	3	3	4	3
695	27	2026-03-09	\N	3	1	4
696	27	2026-03-10	\N	3	5	4
697	27	2026-03-11	\N	3	2	4
698	27	2026-03-12	\N	3	4	4
693	27	2026-03-14	2	3	7	2
699	27	2026-03-13	\N	3	11	4
700	27	2026-03-14	\N	3	9	4
701	27	2026-03-15	\N	3	8	4
702	28	2026-03-09	1	1	3	1
703	28	2026-03-09	1	3	4	1
704	28	2026-03-09	2	3	2	2
705	28	2026-03-09	3	3	11	3
706	28	2026-03-10	1	1	3	1
707	28	2026-03-10	1	3	10	1
708	28	2026-03-10	2	3	4	2
709	28	2026-03-10	3	3	11	3
710	28	2026-03-11	1	1	3	1
711	28	2026-03-11	1	3	1	1
712	28	2026-03-11	2	3	2	2
713	28	2026-03-11	3	3	4	3
714	28	2026-03-12	1	1	3	1
715	28	2026-03-12	1	3	1	1
716	28	2026-03-12	2	3	2	2
717	28	2026-03-12	3	3	11	3
718	28	2026-03-13	1	1	3	1
719	28	2026-03-13	1	3	1	1
720	28	2026-03-13	2	3	4	2
721	28	2026-03-13	3	3	11	3
722	28	2026-03-14	1	1	3	1
723	28	2026-03-14	1	3	1	1
724	28	2026-03-14	2	3	2	2
727	28	2026-03-15	1	3	1	1
728	28	2026-03-15	2	3	2	2
730	28	2026-03-09	\N	3	9	4
731	28	2026-03-10	\N	3	1	4
732	28	2026-03-11	\N	3	11	4
733	28	2026-03-12	\N	3	4	4
734	28	2026-03-13	\N	3	2	4
735	28	2026-03-14	\N	3	7	4
736	28	2026-03-15	\N	3	5	4
807	31	2026-03-30	1	1	3	1
808	31	2026-03-30	1	3	4	1
726	28	2026-03-15	1	1	10	1
729	28	2026-03-15	3	3	4	2
725	28	2026-03-15	3	3	11	3
737	29	2026-03-09	1	1	3	1
738	29	2026-03-09	1	3	1	1
739	29	2026-03-09	2	3	2	2
740	29	2026-03-09	3	3	11	3
741	29	2026-03-10	1	1	3	1
742	29	2026-03-10	1	3	1	1
743	29	2026-03-10	2	3	4	2
744	29	2026-03-10	3	3	11	3
745	29	2026-03-11	1	1	3	1
746	29	2026-03-11	1	3	4	1
747	29	2026-03-11	2	3	2	2
748	29	2026-03-11	3	3	11	3
749	29	2026-03-12	1	1	9	1
750	29	2026-03-12	1	3	1	1
751	29	2026-03-12	2	3	4	2
753	29	2026-03-13	1	1	3	1
754	29	2026-03-13	1	3	1	1
755	29	2026-03-13	2	3	2	2
756	29	2026-03-13	3	3	11	3
757	29	2026-03-14	1	1	3	1
758	29	2026-03-14	1	3	4	1
759	29	2026-03-14	2	3	2	2
761	29	2026-03-15	1	1	3	1
762	29	2026-03-15	1	3	1	1
763	29	2026-03-15	2	3	2	2
765	29	2026-03-09	\N	3	5	4
766	29	2026-03-10	\N	3	10	4
767	29	2026-03-11	\N	3	1	4
768	29	2026-03-12	\N	3	2	4
769	29	2026-03-13	\N	3	4	4
771	29	2026-03-15	\N	3	11	4
809	31	2026-03-30	2	3	2	2
764	29	2026-03-15	3	3	4	3
810	31	2026-03-30	3	3	11	3
760	29	2026-03-14	3	3	11	4
770	29	2026-03-13	\N	3	8	2
752	29	2026-03-14	3	3	8	3
772	30	2026-03-23	1	1	3	1
773	30	2026-03-23	1	3	1	1
774	30	2026-03-23	2	3	2	2
775	30	2026-03-23	3	3	11	3
776	30	2026-03-24	1	1	3	1
777	30	2026-03-24	1	3	4	1
778	30	2026-03-24	2	3	2	2
779	30	2026-03-24	3	3	11	3
780	30	2026-03-25	1	1	3	1
781	30	2026-03-25	1	3	1	1
782	30	2026-03-25	2	3	2	2
783	30	2026-03-25	3	3	4	3
784	30	2026-03-26	1	1	3	1
785	30	2026-03-26	1	3	6	1
786	30	2026-03-26	2	3	4	2
787	30	2026-03-26	3	3	11	3
788	30	2026-03-27	1	1	3	1
789	30	2026-03-27	1	3	1	1
790	30	2026-03-27	2	3	2	2
792	30	2026-03-28	1	1	3	1
793	30	2026-03-28	1	3	1	1
794	30	2026-03-28	2	3	7	2
796	30	2026-03-29	1	1	4	1
797	30	2026-03-29	1	3	1	1
798	30	2026-03-29	2	3	2	2
800	30	2026-03-23	\N	3	4	4
801	30	2026-03-24	\N	3	10	4
802	30	2026-03-25	\N	3	11	4
803	30	2026-03-26	\N	3	1	4
804	30	2026-03-27	\N	3	7	4
805	30	2026-03-28	\N	3	2	4
806	30	2026-03-29	\N	3	5	4
811	31	2026-03-31	1	1	3	1
812	31	2026-03-31	1	3	1	1
795	30	2026-03-27	3	3	11	3
814	31	2026-03-31	3	3	11	3
791	30	2026-03-28	3	3	4	3
799	30	2026-03-29	3	3	11	3
815	31	2026-04-01	1	1	3	1
816	31	2026-04-01	1	3	1	1
817	31	2026-04-01	2	3	2	2
818	31	2026-04-01	3	3	4	3
819	31	2026-04-02	1	1	3	1
820	31	2026-04-02	1	3	1	1
822	31	2026-04-02	3	3	11	3
823	31	2026-04-03	1	1	3	1
824	31	2026-04-03	1	3	1	1
825	31	2026-04-03	2	3	4	2
826	31	2026-04-03	3	3	11	3
827	31	2026-04-04	1	1	3	1
828	31	2026-04-04	1	3	9	1
830	31	2026-04-04	3	3	6	3
831	31	2026-04-05	1	1	4	1
832	31	2026-04-05	1	3	1	1
833	31	2026-04-05	2	3	2	2
834	31	2026-04-05	3	3	11	3
835	31	2026-03-30	\N	3	1	4
836	31	2026-03-31	\N	3	2	4
837	31	2026-04-01	\N	3	11	4
838	31	2026-04-02	\N	3	4	4
839	31	2026-04-03	\N	3	9	4
840	31	2026-04-04	\N	3	8	4
841	31	2026-04-05	\N	3	10	4
829	31	2026-04-04	2	3	2	2
821	31	2026-04-02	2	3	2	2
813	31	2026-03-31	2	3	4	2
842	32	2026-03-23	1	1	3	1
843	32	2026-03-23	1	3	4	1
844	32	2026-03-23	2	3	2	2
845	32	2026-03-23	3	3	11	3
846	32	2026-03-24	1	1	3	1
847	32	2026-03-24	1	3	1	1
848	32	2026-03-24	2	3	2	2
849	32	2026-03-24	3	3	7	3
850	32	2026-03-25	1	1	3	1
851	32	2026-03-25	1	3	1	1
852	32	2026-03-25	2	3	4	2
853	32	2026-03-25	3	3	11	3
854	32	2026-03-26	1	1	3	1
855	32	2026-03-26	1	3	1	1
856	32	2026-03-26	2	3	4	2
857	32	2026-03-26	3	3	11	3
858	32	2026-03-27	1	1	3	1
859	32	2026-03-27	1	3	1	1
860	32	2026-03-27	2	3	2	2
861	32	2026-03-27	3	3	4	3
862	32	2026-03-28	1	1	10	1
863	32	2026-03-28	1	3	1	1
864	32	2026-03-28	2	3	2	2
865	32	2026-03-28	3	3	11	3
866	32	2026-03-29	1	1	3	1
867	32	2026-03-29	1	3	4	1
868	32	2026-03-29	2	3	2	2
869	32	2026-03-29	3	3	11	3
870	32	2026-03-23	\N	3	1	4
871	32	2026-03-24	\N	3	4	4
872	32	2026-03-25	\N	3	7	4
873	32	2026-03-26	\N	3	2	4
876	32	2026-03-29	\N	3	6	4
927	34	2026-04-17	3	3	11	3
875	32	2026-03-27	\N	3	9	4
874	32	2026-03-27	\N	3	11	4
877	33	2026-04-06	1	1	3	1
878	33	2026-04-06	1	3	4	1
879	33	2026-04-06	2	3	2	2
880	33	2026-04-06	3	3	11	3
881	33	2026-04-07	1	1	3	1
882	33	2026-04-07	1	3	1	1
883	33	2026-04-07	2	3	2	2
884	33	2026-04-07	3	3	4	3
885	33	2026-04-08	1	1	3	1
888	33	2026-04-08	3	3	11	3
889	33	2026-04-09	1	1	3	1
891	33	2026-04-09	2	3	2	2
892	33	2026-04-09	3	3	11	3
893	33	2026-04-10	1	1	3	1
894	33	2026-04-10	1	3	1	1
895	33	2026-04-10	2	3	2	2
896	33	2026-04-10	3	3	11	3
897	33	2026-04-11	1	1	4	1
898	33	2026-04-11	1	3	1	1
899	33	2026-04-11	2	3	8	2
900	33	2026-04-11	3	3	11	3
901	33	2026-04-12	1	1	3	1
902	33	2026-04-12	1	3	4	1
903	33	2026-04-12	2	3	2	2
904	33	2026-04-12	3	3	11	3
905	33	2026-04-06	\N	3	9	4
906	33	2026-04-07	\N	3	10	4
910	33	2026-04-11	\N	3	2	4
911	33	2026-04-12	\N	3	1	4
931	34	2026-04-16	3	3	6	3
909	33	2026-04-10	\N	3	6	4
943	34	2026-04-17	\N	3	6	4
944	34	2026-04-16	\N	3	11	4
887	33	2026-04-08	2	3	4	2
947	35	2026-04-13	1	1	3	1
948	35	2026-04-13	1	3	1	1
886	33	2026-04-09	1	3	1	1
890	33	2026-04-08	1	3	1	1
949	35	2026-04-13	2	3	4	2
950	35	2026-04-13	3	3	11	3
907	33	2026-04-08	\N	3	5	4
908	33	2026-04-10	\N	3	4	4
912	34	2026-04-13	1	1	3	1
913	34	2026-04-13	1	3	4	1
914	34	2026-04-13	2	3	2	2
915	34	2026-04-13	3	3	11	3
916	34	2026-04-14	1	1	3	1
917	34	2026-04-14	1	3	1	1
918	34	2026-04-14	2	3	4	2
919	34	2026-04-14	3	3	11	3
920	34	2026-04-15	1	1	9	1
921	34	2026-04-15	1	3	1	1
922	34	2026-04-15	2	3	2	2
923	34	2026-04-15	3	3	11	3
924	34	2026-04-16	1	1	3	1
925	34	2026-04-16	1	3	4	1
926	34	2026-04-16	2	3	2	2
928	34	2026-04-17	1	1	3	1
929	34	2026-04-17	1	3	1	1
930	34	2026-04-17	2	3	2	2
932	34	2026-04-18	1	1	3	1
933	34	2026-04-18	1	3	1	1
934	34	2026-04-18	2	3	4	2
935	34	2026-04-18	3	3	11	3
936	34	2026-04-19	1	1	3	1
937	34	2026-04-19	1	3	1	1
938	34	2026-04-19	2	3	2	2
939	34	2026-04-19	3	3	4	3
940	34	2026-04-13	\N	3	1	4
941	34	2026-04-14	\N	3	2	4
942	34	2026-04-15	\N	3	4	4
945	34	2026-04-18	\N	3	8	4
946	34	2026-04-19	\N	3	5	4
951	35	2026-04-14	1	1	3	1
952	35	2026-04-14	1	3	1	1
953	35	2026-04-14	2	3	2	2
954	35	2026-04-14	3	3	11	3
955	35	2026-04-15	1	1	3	1
956	35	2026-04-15	1	3	1	1
957	35	2026-04-15	2	3	2	2
958	35	2026-04-15	3	3	11	3
959	35	2026-04-16	1	1	4	1
960	35	2026-04-16	1	3	1	1
961	35	2026-04-16	2	3	2	2
962	35	2026-04-16	3	3	11	3
963	35	2026-04-17	1	1	3	1
964	35	2026-04-17	1	3	4	1
965	35	2026-04-17	2	3	2	2
966	35	2026-04-17	3	3	11	3
967	35	2026-04-18	1	1	3	1
968	35	2026-04-18	1	3	5	1
969	35	2026-04-18	2	3	2	2
971	35	2026-04-19	1	1	3	1
972	35	2026-04-19	1	3	1	1
973	35	2026-04-19	2	3	4	2
974	35	2026-04-19	3	3	10	3
975	35	2026-04-13	\N	3	2	4
976	35	2026-04-14	\N	3	4	4
977	35	2026-04-15	\N	3	5	4
978	35	2026-04-16	\N	3	9	4
979	35	2026-04-17	\N	3	1	4
981	35	2026-04-19	\N	3	7	4
970	35	2026-04-18	2	3	4	2
980	35	2026-04-18	3	3	11	3
982	36	2026-04-20	1	1	3	1
983	36	2026-04-20	1	3	1	1
984	36	2026-04-20	2	3	8	2
985	36	2026-04-20	3	3	11	3
986	36	2026-04-21	1	1	4	1
987	36	2026-04-21	1	3	1	1
988	36	2026-04-21	2	3	2	2
989	36	2026-04-21	3	3	11	3
990	36	2026-04-22	1	1	3	1
991	36	2026-04-22	1	3	9	1
992	36	2026-04-22	2	3	2	2
993	36	2026-04-22	3	3	4	3
994	36	2026-04-23	1	1	3	1
995	36	2026-04-23	1	3	1	1
996	36	2026-04-23	2	3	2	2
997	36	2026-04-23	3	3	4	3
998	36	2026-04-24	1	1	3	1
999	36	2026-04-24	1	3	4	1
1000	36	2026-04-24	2	3	2	2
1001	36	2026-04-24	3	3	11	3
1002	36	2026-04-25	1	1	3	1
1003	36	2026-04-25	1	3	1	1
1004	36	2026-04-25	2	3	2	2
1006	36	2026-04-26	1	1	3	1
1007	36	2026-04-26	1	3	1	1
1008	36	2026-04-26	2	3	4	2
1010	36	2026-04-20	\N	3	2	4
1011	36	2026-04-21	\N	3	6	4
1012	36	2026-04-22	\N	3	8	4
1013	36	2026-04-23	\N	3	11	4
1014	36	2026-04-24	\N	3	1	4
1016	36	2026-04-26	\N	3	9	4
1082	38	2026-04-08	\N	3	2	4
1015	36	2026-04-25	3	3	4	3
1084	38	2026-04-09	\N	3	5	4
1005	36	2026-04-26	3	3	11	3
1087	39	2026-04-06	1	1	3	1
1088	39	2026-04-06	1	3	9	1
1009	36	2026-04-25	3	3	11	3
1017	37	2026-04-06	1	1	10	1
1018	37	2026-04-06	1	3	4	1
1019	37	2026-04-06	2	3	2	2
1020	37	2026-04-06	3	3	11	3
1021	37	2026-04-07	1	1	3	1
1022	37	2026-04-07	1	3	1	1
1023	37	2026-04-07	2	3	2	2
1024	37	2026-04-07	3	3	11	3
1025	37	2026-04-08	1	1	3	1
1026	37	2026-04-08	1	3	1	1
1027	37	2026-04-08	2	3	4	2
1028	37	2026-04-08	3	3	11	3
1029	37	2026-04-09	1	1	3	1
1030	37	2026-04-09	1	3	1	1
1031	37	2026-04-09	2	3	2	2
1032	37	2026-04-09	3	3	4	3
1033	37	2026-04-10	1	1	3	1
1034	37	2026-04-10	1	3	1	1
1035	37	2026-04-10	2	3	4	2
1036	37	2026-04-10	3	3	11	3
1037	37	2026-04-11	1	1	3	1
1038	37	2026-04-11	1	3	1	1
1039	37	2026-04-11	2	3	2	2
1040	37	2026-04-11	3	3	4	3
1041	37	2026-04-12	1	1	3	1
1042	37	2026-04-12	1	3	4	1
1043	37	2026-04-12	2	3	2	2
1046	37	2026-04-07	\N	3	8	4
1047	37	2026-04-08	\N	3	6	4
1048	37	2026-04-09	\N	3	11	4
1051	37	2026-04-12	\N	3	1	4
1089	39	2026-04-06	2	3	4	2
1090	39	2026-04-06	3	3	11	3
1091	39	2026-04-07	1	1	3	1
1044	37	2026-04-12	3	3	11	3
1092	39	2026-04-07	1	3	1	1
1093	39	2026-04-07	2	3	2	2
1050	37	2026-04-11	\N	3	10	4
1094	39	2026-04-07	3	3	11	3
1045	37	2026-04-07	\N	3	5	4
1049	37	2026-04-10	\N	3	2	4
1052	38	2026-04-06	1	1	3	1
1053	38	2026-04-06	1	3	1	1
1054	38	2026-04-06	2	3	2	2
1055	38	2026-04-06	3	3	4	3
1056	38	2026-04-07	1	1	3	1
1057	38	2026-04-07	1	3	4	1
1058	38	2026-04-07	2	3	2	2
1059	38	2026-04-07	3	3	11	3
1060	38	2026-04-08	1	1	3	1
1061	38	2026-04-08	1	3	1	1
1062	38	2026-04-08	2	3	4	2
1063	38	2026-04-08	3	3	11	3
1064	38	2026-04-09	1	1	3	1
1065	38	2026-04-09	1	3	1	1
1066	38	2026-04-09	2	3	2	2
1067	38	2026-04-09	3	3	11	3
1068	38	2026-04-10	1	1	3	1
1069	38	2026-04-10	1	3	4	1
1070	38	2026-04-10	2	3	2	2
1071	38	2026-04-10	3	3	11	3
1072	38	2026-04-11	1	1	10	1
1073	38	2026-04-11	1	3	1	1
1074	38	2026-04-11	2	3	9	2
1075	38	2026-04-11	3	3	4	3
1076	38	2026-04-12	1	1	3	1
1077	38	2026-04-12	1	3	1	1
1078	38	2026-04-12	2	3	2	2
1079	38	2026-04-12	3	3	11	3
1080	38	2026-04-06	\N	3	11	4
1081	38	2026-04-07	\N	3	1	4
1083	38	2026-04-09	\N	3	4	4
1085	38	2026-04-11	\N	3	6	4
1086	38	2026-04-12	\N	3	8	4
1095	39	2026-04-08	1	1	4	1
1096	39	2026-04-08	1	3	1	1
1097	39	2026-04-08	2	3	2	2
1098	39	2026-04-08	3	3	11	3
1099	39	2026-04-09	1	1	3	1
1100	39	2026-04-09	1	3	1	1
1101	39	2026-04-09	2	3	2	2
1102	39	2026-04-09	3	3	4	3
1103	39	2026-04-10	1	1	3	1
1104	39	2026-04-10	1	3	4	1
1105	39	2026-04-10	2	3	2	2
1106	39	2026-04-10	3	3	11	3
1107	39	2026-04-11	1	1	3	1
1108	39	2026-04-11	1	3	1	1
1109	39	2026-04-11	2	3	2	2
1110	39	2026-04-11	3	3	11	3
1111	39	2026-04-12	1	1	3	1
1112	39	2026-04-12	1	3	1	1
1113	39	2026-04-12	2	3	7	2
1114	39	2026-04-12	3	3	4	3
1115	39	2026-04-06	\N	3	2	4
1116	39	2026-04-07	\N	3	9	4
1117	39	2026-04-08	\N	3	7	4
1118	39	2026-04-09	\N	3	11	4
1119	39	2026-04-10	\N	3	1	4
1120	39	2026-04-11	\N	3	4	4
1121	39	2026-04-11	\N	3	5	4
1122	40	2026-03-16	1	1	3	1
1123	40	2026-03-16	1	3	1	1
1124	40	2026-03-16	2	3	4	2
1125	40	2026-03-16	3	3	11	3
1126	40	2026-03-17	1	1	10	1
1127	40	2026-03-17	1	3	9	1
1129	40	2026-03-17	3	3	11	3
1130	40	2026-03-18	1	1	3	1
1131	40	2026-03-18	1	3	1	1
1133	40	2026-03-18	3	3	11	3
1134	40	2026-03-19	1	1	3	1
1135	40	2026-03-19	1	3	1	1
1136	40	2026-03-19	2	3	2	2
1137	40	2026-03-19	3	3	11	3
1138	40	2026-03-20	1	1	3	1
1139	40	2026-03-20	1	3	1	1
1140	40	2026-03-20	2	3	2	2
1142	40	2026-03-21	1	1	3	1
1143	40	2026-03-21	1	3	1	1
1144	40	2026-03-21	2	3	2	2
1145	40	2026-03-21	3	3	4	3
1146	40	2026-03-22	1	1	3	1
1147	40	2026-03-22	1	3	4	1
1148	40	2026-03-22	2	3	2	2
1149	40	2026-03-22	3	3	11	3
1150	40	2026-03-16	\N	3	2	4
1151	40	2026-03-17	\N	3	1	4
1152	40	2026-03-18	\N	3	5	4
1153	40	2026-03-19	\N	3	4	4
1156	40	2026-03-22	\N	3	8	4
1155	40	2026-03-21	\N	3	6	4
1224	42	2026-03-20	\N	3	7	4
1128	40	2026-03-18	2	3	4	2
1132	40	2026-03-17	2	3	2	2
1207	42	2026-03-19	\N	3	11	4
1141	40	2026-03-20	3	3	4	3
1154	40	2026-03-21	\N	3	11	4
1157	41	2026-03-09	1	1	3	1
1158	41	2026-03-09	1	3	4	1
1159	41	2026-03-09	2	3	2	2
1160	41	2026-03-09	3	3	11	3
1161	41	2026-03-10	1	1	3	1
1162	41	2026-03-10	1	3	1	1
1163	41	2026-03-10	2	3	4	2
1164	41	2026-03-10	3	3	11	3
1165	41	2026-03-11	1	1	3	1
1166	41	2026-03-11	1	3	1	1
1167	41	2026-03-11	2	3	2	2
1168	41	2026-03-11	3	3	4	3
1169	41	2026-03-12	1	1	3	1
1170	41	2026-03-12	1	3	1	1
1171	41	2026-03-12	2	3	2	2
1172	41	2026-03-12	3	3	11	3
1173	41	2026-03-13	1	1	3	1
1174	41	2026-03-13	1	3	1	1
1175	41	2026-03-13	2	3	2	2
1176	41	2026-03-13	3	3	11	3
1177	41	2026-03-14	1	1	10	1
1178	41	2026-03-14	1	3	6	1
1179	41	2026-03-14	2	3	4	2
1180	41	2026-03-14	3	3	11	3
1181	41	2026-03-15	1	1	3	1
1182	41	2026-03-15	1	3	1	1
1183	41	2026-03-15	2	3	2	2
1184	41	2026-03-15	3	3	4	3
1185	41	2026-03-09	\N	3	1	4
1186	41	2026-03-10	\N	3	2	4
1189	41	2026-03-13	\N	3	4	4
1190	41	2026-03-14	\N	3	8	4
1191	41	2026-03-15	\N	3	11	4
1223	42	2026-03-19	\N	3	2	4
1187	41	2026-03-11	\N	3	9	4
1188	41	2026-03-13	\N	3	5	4
1192	42	2026-03-16	1	1	4	1
1193	42	2026-03-16	1	3	1	1
1194	42	2026-03-16	2	3	2	2
1195	42	2026-03-16	3	3	11	3
1196	42	2026-03-17	1	1	3	1
1197	42	2026-03-17	1	3	1	1
1198	42	2026-03-17	2	3	2	2
1199	42	2026-03-17	3	3	11	3
1200	42	2026-03-18	1	1	3	1
1201	42	2026-03-18	1	3	4	1
1202	42	2026-03-18	2	3	2	2
1203	42	2026-03-18	3	3	11	3
1204	42	2026-03-19	1	1	3	1
1205	42	2026-03-19	1	3	1	1
1206	42	2026-03-19	2	3	4	2
1208	42	2026-03-20	1	1	3	1
1209	42	2026-03-20	1	3	1	1
1210	42	2026-03-20	2	3	4	2
1211	42	2026-03-20	3	3	11	3
1212	42	2026-03-21	1	1	3	1
1213	42	2026-03-21	1	3	7	1
1214	42	2026-03-21	2	3	2	2
1215	42	2026-03-21	3	3	4	3
1216	42	2026-03-22	1	1	3	1
1217	42	2026-03-22	1	3	1	1
1218	42	2026-03-22	2	3	2	2
1219	42	2026-03-22	3	3	11	3
1220	42	2026-03-16	\N	3	6	4
1221	42	2026-03-17	\N	3	5	4
1222	42	2026-03-18	\N	3	1	4
1225	42	2026-03-21	\N	3	8	4
1226	42	2026-03-22	\N	3	4	4
\.


--
-- Data for Name: lich_tuan; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.lich_tuan (id, ngay_bat_dau, ngay_ket_thuc, trang_thai, ghi_chu) FROM stdin;
1	2026-01-24	2026-01-30	DA_XEP	\N
2	2026-01-19	2026-01-25	DA_XEP	\N
3	2026-01-19	2026-01-25	DA_XEP	\N
4	2026-01-19	2026-01-25	DA_XEP	\N
5	2026-01-19	2026-01-25	DA_XEP	\N
6	2026-01-19	2026-01-25	DA_XEP	\N
7	2026-01-19	2026-01-25	DA_XEP	\N
8	2026-01-26	2026-02-01	DA_XEP	\N
9	2026-01-19	2026-01-25	DA_XEP	\N
10	2026-01-26	2026-02-01	DA_XEP	\N
11	2026-02-02	2026-02-08	DA_XEP	\N
12	2026-01-12	2026-01-18	DA_XEP	\N
13	2026-01-26	2026-02-01	DA_XEP	\N
14	2026-01-26	2026-02-01	DA_XEP	\N
15	2026-01-26	2026-02-01	DA_XEP	\N
16	2026-01-26	2026-02-01	DA_XEP	\N
17	2026-01-19	2026-01-25	DA_XEP	\N
18	2026-01-26	2026-02-01	DA_XEP	\N
19	2026-02-02	2026-02-08	DA_XEP	\N
20	2026-02-23	2026-03-01	DA_XEP	\N
21	2026-03-09	2026-03-15	DA_XEP	\N
22	2026-03-23	2026-03-29	DA_XEP	\N
23	2026-03-23	2026-03-29	DA_XEP	\N
24	2026-03-30	2026-04-05	DA_XEP	\N
25	2026-03-30	2026-04-05	DA_XEP	\N
26	2026-03-23	2026-03-29	DA_XEP	\N
27	2026-03-09	2026-03-15	DA_XEP	\N
28	2026-03-09	2026-03-15	DA_XEP	\N
29	2026-03-09	2026-03-15	DA_XEP	\N
30	2026-03-23	2026-03-29	DA_XEP	\N
31	2026-03-30	2026-04-05	DA_XEP	\N
32	2026-03-23	2026-03-29	DA_XEP	\N
33	2026-04-06	2026-04-12	DA_XEP	\N
34	2026-04-13	2026-04-19	DA_XEP	\N
35	2026-04-13	2026-04-19	DA_XEP	\N
36	2026-04-20	2026-04-26	DA_XEP	\N
37	2026-04-06	2026-04-12	DA_XEP	\N
38	2026-04-06	2026-04-12	DA_XEP	\N
39	2026-04-06	2026-04-12	DA_XEP	\N
40	2026-03-16	2026-03-22	DA_XEP	\N
41	2026-03-09	2026-03-15	DA_XEP	\N
42	2026-03-16	2026-03-22	DA_XEP	\N
\.


--
-- Data for Name: mapping_nhom; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.mapping_nhom (id, chi_nhanh_id, ca_id, nhom_hien_thi_id) FROM stdin;
1	1	1	1
2	2	1	2
3	1	2	1
4	1	3	1
5	2	3	2
6	3	3	3
7	\N	3	4
8	1	4	1
9	2	4	2
10	\N	5	5
\.


--
-- Data for Name: ngay_nghi; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.ngay_nghi (id, nhan_vien_id, ngay, trang_thai, ghi_chu) FROM stdin;
\.


--
-- Data for Name: nhan_vien; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhan_vien (id, ma_nv, ten_nv, cap_do, muc_uu_tien, gio_toi_da_tuan, ghi_chu) FROM stdin;
1	BS01	Hữu	Bác sỹ chính	5	66	\N
2	BS02	Nhựt	Bác sỹ chính	5	66	\N
3	BS03	Hồng	Bác sỹ chính	5	66	\N
4	BS04	Thy	Bác sỹ chính	5	66	\N
5	BS05	Thùy	Bác sỹ mới	2	66	\N
6	BS06	My	Bác sỹ mới	2	66	\N
7	BS07	Hà	Bác sỹ mới	2	66	\N
8	BS08	Đạt	Bác sỹ mới	2	66	\N
9	BS09	Hiếu	Bác sỹ mới	2	66	\N
10	BS10	Phong	Bác sỹ mới	2	66	\N
11	BS11	Đăng	Bác sỹ chính	2	66	\N
\.


--
-- Data for Name: nhan_vien_ca_tranh; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhan_vien_ca_tranh (nhan_vien_id, ca_id) FROM stdin;
4	4
\.


--
-- Data for Name: nhan_vien_ca_ua_thich; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhan_vien_ca_ua_thich (nhan_vien_id, ca_id) FROM stdin;
3	1
2	4
1	3
\.


--
-- Data for Name: nhan_vien_chi_nhanh; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhan_vien_chi_nhanh (nhan_vien_id, chi_nhanh_id) FROM stdin;
1	1
11	3
2	2
\.


--
-- Data for Name: nhan_vien_trong_so; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhan_vien_trong_so (id, nhan_vien_id, trong_so_id, muc_uu_tien) FROM stdin;
1	11	6	1
2	11	2	1
3	8	2	6
4	8	6	2
\.


--
-- Data for Name: nhan_vien_vai_tro; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhan_vien_vai_tro (nhan_vien_id, vai_tro_id) FROM stdin;
8	1
3	1
2	1
9	1
4	1
10	1
5	1
11	1
6	1
1	1
7	1
\.


--
-- Data for Name: nhom_hien_thi; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhom_hien_thi (id, ten_nhom, mau_nen) FROM stdin;
1	326TTV	#d7f2ff
2	197LT5	#d9f7e6
3	796ADV	#fff1c9
4	CN	#ffd8e6
5	Spa	#e6e6e6
\.


--
-- Data for Name: nhu_cau_ca; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.nhu_cau_ca (id, ngay, chi_nhanh_id, ca_id, so_nguoi_can, vai_tro_yeu_cau_id, do_quan_trong, senior_toi_thieu) FROM stdin;
1	2026-01-19	1	1	1	\N	3	\N
2	2026-01-19	1	3	1	\N	4	\N
3	2026-01-19	2	3	1	\N	3	\N
4	2026-01-19	3	3	1	\N	2	\N
5	2026-01-20	1	1	1	\N	3	\N
6	2026-01-20	1	3	1	\N	4	\N
7	2026-01-20	2	3	1	\N	3	\N
8	2026-01-20	3	3	1	\N	2	\N
9	2026-01-21	1	1	1	\N	3	\N
10	2026-01-21	1	3	1	\N	4	\N
11	2026-01-21	2	3	1	\N	3	\N
12	2026-01-21	3	3	1	\N	2	\N
13	2026-01-22	1	1	1	\N	3	\N
14	2026-01-22	1	3	1	\N	4	\N
15	2026-01-22	2	3	1	\N	3	\N
16	2026-01-22	3	3	1	\N	2	\N
17	2026-01-23	1	1	1	\N	3	\N
18	2026-01-23	1	3	1	\N	4	\N
19	2026-01-23	2	3	1	\N	3	\N
20	2026-01-23	3	3	1	\N	2	\N
21	2026-01-24	1	1	1	\N	3	\N
22	2026-01-24	1	3	1	\N	4	\N
23	2026-01-24	2	3	1	\N	3	\N
24	2026-01-24	3	3	1	\N	2	\N
25	2026-01-25	1	1	1	\N	3	\N
26	2026-01-25	1	3	1	\N	4	\N
27	2026-01-25	2	3	1	\N	3	\N
28	2026-01-25	3	3	1	\N	2	\N
29	2026-01-26	1	1	1	\N	3	\N
30	2026-01-26	1	3	1	\N	4	\N
31	2026-01-26	2	3	1	\N	3	\N
32	2026-01-26	3	3	1	\N	2	\N
33	2026-01-27	1	1	1	\N	3	\N
34	2026-01-27	1	3	1	\N	4	\N
35	2026-01-27	2	3	1	\N	3	\N
36	2026-01-27	3	3	1	\N	2	\N
37	2026-01-28	1	1	1	\N	3	\N
38	2026-01-28	1	3	1	\N	4	\N
39	2026-01-28	2	3	1	\N	3	\N
40	2026-01-28	3	3	1	\N	2	\N
41	2026-01-29	1	1	1	\N	3	\N
42	2026-01-29	1	3	1	\N	4	\N
43	2026-01-29	2	3	1	\N	3	\N
44	2026-01-29	3	3	1	\N	2	\N
45	2026-01-30	1	1	1	\N	3	\N
46	2026-01-30	1	3	1	\N	4	\N
47	2026-01-30	2	3	1	\N	3	\N
48	2026-01-30	3	3	1	\N	2	\N
49	2026-01-31	1	1	1	\N	3	\N
50	2026-01-31	1	3	1	\N	4	\N
51	2026-01-31	2	3	1	\N	3	\N
52	2026-01-31	3	3	1	\N	2	\N
53	2026-02-01	1	1	1	\N	3	\N
54	2026-02-01	1	3	1	\N	4	\N
55	2026-02-01	2	3	1	\N	3	\N
56	2026-02-01	3	3	1	\N	2	\N
57	2026-02-02	1	1	1	\N	3	\N
58	2026-02-02	1	3	1	\N	4	\N
59	2026-02-02	2	3	1	\N	3	\N
60	2026-02-02	3	3	1	\N	2	\N
61	2026-02-03	1	1	1	\N	3	\N
62	2026-02-03	1	3	1	\N	4	\N
63	2026-02-03	2	3	1	\N	3	\N
64	2026-02-03	3	3	1	\N	2	\N
65	2026-02-04	1	1	1	\N	3	\N
66	2026-02-04	1	3	1	\N	4	\N
67	2026-02-04	2	3	1	\N	3	\N
68	2026-02-04	3	3	1	\N	2	\N
69	2026-02-05	1	1	1	\N	3	\N
70	2026-02-05	1	3	1	\N	4	\N
71	2026-02-05	2	3	1	\N	3	\N
72	2026-02-05	3	3	1	\N	2	\N
73	2026-02-06	1	1	1	\N	3	\N
74	2026-02-06	1	3	1	\N	4	\N
75	2026-02-06	2	3	1	\N	3	\N
76	2026-02-06	3	3	1	\N	2	\N
77	2026-02-07	1	1	1	\N	3	\N
78	2026-02-07	1	3	1	\N	4	\N
79	2026-02-07	2	3	1	\N	3	\N
80	2026-02-07	3	3	1	\N	2	\N
81	2026-02-08	1	1	1	\N	3	\N
82	2026-02-08	1	3	1	\N	4	\N
83	2026-02-08	2	3	1	\N	3	\N
84	2026-02-08	3	3	1	\N	2	\N
85	2026-02-23	1	1	1	\N	3	\N
86	2026-02-23	1	3	1	\N	4	\N
87	2026-02-23	2	3	1	\N	3	\N
88	2026-02-23	3	3	1	\N	2	\N
89	2026-02-24	1	1	1	\N	3	\N
90	2026-02-24	1	3	1	\N	4	\N
91	2026-02-24	2	3	1	\N	3	\N
92	2026-02-24	3	3	1	\N	2	\N
93	2026-02-25	1	1	1	\N	3	\N
94	2026-02-25	1	3	1	\N	4	\N
95	2026-02-25	2	3	1	\N	3	\N
96	2026-02-25	3	3	1	\N	2	\N
97	2026-02-26	1	1	1	\N	3	\N
98	2026-02-26	1	3	1	\N	4	\N
99	2026-02-26	2	3	1	\N	3	\N
100	2026-02-26	3	3	1	\N	2	\N
101	2026-02-27	1	1	1	\N	3	\N
102	2026-02-27	1	3	1	\N	4	\N
103	2026-02-27	2	3	1	\N	3	\N
104	2026-02-27	3	3	1	\N	2	\N
105	2026-02-28	1	1	1	\N	3	\N
106	2026-02-28	1	3	1	\N	4	\N
107	2026-02-28	2	3	1	\N	3	\N
108	2026-02-28	3	3	1	\N	2	\N
109	2026-03-01	1	1	1	\N	3	\N
110	2026-03-01	1	3	1	\N	4	\N
111	2026-03-01	2	3	1	\N	3	\N
112	2026-03-01	3	3	1	\N	2	\N
113	2026-03-09	1	1	1	\N	3	\N
114	2026-03-09	1	3	1	\N	4	\N
115	2026-03-09	2	3	1	\N	3	\N
116	2026-03-09	3	3	1	\N	2	\N
117	2026-03-10	1	1	1	\N	3	\N
118	2026-03-10	1	3	1	\N	4	\N
119	2026-03-10	2	3	1	\N	3	\N
120	2026-03-10	3	3	1	\N	2	\N
121	2026-03-11	1	1	1	\N	3	\N
122	2026-03-11	1	3	1	\N	4	\N
123	2026-03-11	2	3	1	\N	3	\N
124	2026-03-11	3	3	1	\N	2	\N
125	2026-03-12	1	1	1	\N	3	\N
126	2026-03-12	1	3	1	\N	4	\N
127	2026-03-12	2	3	1	\N	3	\N
128	2026-03-12	3	3	1	\N	2	\N
129	2026-03-13	1	1	1	\N	3	\N
130	2026-03-13	1	3	1	\N	4	\N
131	2026-03-13	2	3	1	\N	3	\N
132	2026-03-13	3	3	1	\N	2	\N
133	2026-03-14	1	1	1	\N	3	\N
134	2026-03-14	1	3	1	\N	4	\N
135	2026-03-14	2	3	1	\N	3	\N
136	2026-03-14	3	3	1	\N	2	\N
137	2026-03-15	1	1	1	\N	3	\N
138	2026-03-15	1	3	1	\N	4	\N
139	2026-03-15	2	3	1	\N	3	\N
140	2026-03-15	3	3	1	\N	2	\N
141	2026-03-23	1	1	1	\N	3	\N
142	2026-03-23	1	3	1	\N	4	\N
143	2026-03-23	2	3	1	\N	3	\N
144	2026-03-23	3	3	1	\N	2	\N
145	2026-03-24	1	1	1	\N	3	\N
146	2026-03-24	1	3	1	\N	4	\N
147	2026-03-24	2	3	1	\N	3	\N
148	2026-03-24	3	3	1	\N	2	\N
149	2026-03-25	1	1	1	\N	3	\N
150	2026-03-25	1	3	1	\N	4	\N
151	2026-03-25	2	3	1	\N	3	\N
152	2026-03-25	3	3	1	\N	2	\N
153	2026-03-26	1	1	1	\N	3	\N
154	2026-03-26	1	3	1	\N	4	\N
155	2026-03-26	2	3	1	\N	3	\N
156	2026-03-26	3	3	1	\N	2	\N
157	2026-03-27	1	1	1	\N	3	\N
158	2026-03-27	1	3	1	\N	4	\N
159	2026-03-27	2	3	1	\N	3	\N
160	2026-03-27	3	3	1	\N	2	\N
161	2026-03-28	1	1	1	\N	3	\N
162	2026-03-28	1	3	1	\N	4	\N
163	2026-03-28	2	3	1	\N	3	\N
164	2026-03-28	3	3	1	\N	2	\N
165	2026-03-29	1	1	1	\N	3	\N
166	2026-03-29	1	3	1	\N	4	\N
167	2026-03-29	2	3	1	\N	3	\N
168	2026-03-29	3	3	1	\N	2	\N
169	2026-03-30	1	1	1	\N	3	\N
170	2026-03-30	1	3	1	\N	4	\N
171	2026-03-30	2	3	1	\N	3	\N
172	2026-03-30	3	3	1	\N	2	\N
173	2026-03-31	1	1	1	\N	3	\N
174	2026-03-31	1	3	1	\N	4	\N
175	2026-03-31	2	3	1	\N	3	\N
176	2026-03-31	3	3	1	\N	2	\N
177	2026-04-01	1	1	1	\N	3	\N
178	2026-04-01	1	3	1	\N	4	\N
179	2026-04-01	2	3	1	\N	3	\N
180	2026-04-01	3	3	1	\N	2	\N
181	2026-04-02	1	1	1	\N	3	\N
182	2026-04-02	1	3	1	\N	4	\N
183	2026-04-02	2	3	1	\N	3	\N
184	2026-04-02	3	3	1	\N	2	\N
185	2026-04-03	1	1	1	\N	3	\N
186	2026-04-03	1	3	1	\N	4	\N
187	2026-04-03	2	3	1	\N	3	\N
188	2026-04-03	3	3	1	\N	2	\N
189	2026-04-04	1	1	1	\N	3	\N
190	2026-04-04	1	3	1	\N	4	\N
191	2026-04-04	2	3	1	\N	3	\N
192	2026-04-04	3	3	1	\N	2	\N
193	2026-04-05	1	1	1	\N	3	\N
194	2026-04-05	1	3	1	\N	4	\N
195	2026-04-05	2	3	1	\N	3	\N
196	2026-04-05	3	3	1	\N	2	\N
197	2026-04-06	1	1	1	\N	3	\N
198	2026-04-06	1	3	1	\N	4	\N
199	2026-04-06	2	3	1	\N	3	\N
200	2026-04-06	3	3	1	\N	2	\N
201	2026-04-07	1	1	1	\N	3	\N
202	2026-04-07	1	3	1	\N	4	\N
203	2026-04-07	2	3	1	\N	3	\N
204	2026-04-07	3	3	1	\N	2	\N
205	2026-04-08	1	1	1	\N	3	\N
206	2026-04-08	1	3	1	\N	4	\N
207	2026-04-08	2	3	1	\N	3	\N
208	2026-04-08	3	3	1	\N	2	\N
209	2026-04-09	1	1	1	\N	3	\N
210	2026-04-09	1	3	1	\N	4	\N
211	2026-04-09	2	3	1	\N	3	\N
212	2026-04-09	3	3	1	\N	2	\N
213	2026-04-10	1	1	1	\N	3	\N
214	2026-04-10	1	3	1	\N	4	\N
215	2026-04-10	2	3	1	\N	3	\N
216	2026-04-10	3	3	1	\N	2	\N
217	2026-04-11	1	1	1	\N	3	\N
218	2026-04-11	1	3	1	\N	4	\N
219	2026-04-11	2	3	1	\N	3	\N
220	2026-04-11	3	3	1	\N	2	\N
221	2026-04-12	1	1	1	\N	3	\N
222	2026-04-12	1	3	1	\N	4	\N
223	2026-04-12	2	3	1	\N	3	\N
224	2026-04-12	3	3	1	\N	2	\N
225	2026-04-13	1	1	1	\N	3	\N
226	2026-04-13	1	3	1	\N	4	\N
227	2026-04-13	2	3	1	\N	3	\N
228	2026-04-13	3	3	1	\N	2	\N
229	2026-04-14	1	1	1	\N	3	\N
230	2026-04-14	1	3	1	\N	4	\N
231	2026-04-14	2	3	1	\N	3	\N
232	2026-04-14	3	3	1	\N	2	\N
233	2026-04-15	1	1	1	\N	3	\N
234	2026-04-15	1	3	1	\N	4	\N
235	2026-04-15	2	3	1	\N	3	\N
236	2026-04-15	3	3	1	\N	2	\N
237	2026-04-16	1	1	1	\N	3	\N
238	2026-04-16	1	3	1	\N	4	\N
239	2026-04-16	2	3	1	\N	3	\N
240	2026-04-16	3	3	1	\N	2	\N
241	2026-04-17	1	1	1	\N	3	\N
242	2026-04-17	1	3	1	\N	4	\N
243	2026-04-17	2	3	1	\N	3	\N
244	2026-04-17	3	3	1	\N	2	\N
245	2026-04-18	1	1	1	\N	3	\N
246	2026-04-18	1	3	1	\N	4	\N
247	2026-04-18	2	3	1	\N	3	\N
248	2026-04-18	3	3	1	\N	2	\N
249	2026-04-19	1	1	1	\N	3	\N
250	2026-04-19	1	3	1	\N	4	\N
251	2026-04-19	2	3	1	\N	3	\N
252	2026-04-19	3	3	1	\N	2	\N
253	2026-04-20	1	1	1	\N	3	\N
254	2026-04-20	1	3	1	\N	4	\N
255	2026-04-20	2	3	1	\N	3	\N
256	2026-04-20	3	3	1	\N	2	\N
257	2026-04-21	1	1	1	\N	3	\N
258	2026-04-21	1	3	1	\N	4	\N
259	2026-04-21	2	3	1	\N	3	\N
260	2026-04-21	3	3	1	\N	2	\N
261	2026-04-22	1	1	1	\N	3	\N
262	2026-04-22	1	3	1	\N	4	\N
263	2026-04-22	2	3	1	\N	3	\N
264	2026-04-22	3	3	1	\N	2	\N
265	2026-04-23	1	1	1	\N	3	\N
266	2026-04-23	1	3	1	\N	4	\N
267	2026-04-23	2	3	1	\N	3	\N
268	2026-04-23	3	3	1	\N	2	\N
269	2026-04-24	1	1	1	\N	3	\N
270	2026-04-24	1	3	1	\N	4	\N
271	2026-04-24	2	3	1	\N	3	\N
272	2026-04-24	3	3	1	\N	2	\N
273	2026-04-25	1	1	1	\N	3	\N
274	2026-04-25	1	3	1	\N	4	\N
275	2026-04-25	2	3	1	\N	3	\N
276	2026-04-25	3	3	1	\N	2	\N
277	2026-04-26	1	1	1	\N	3	\N
278	2026-04-26	1	3	1	\N	4	\N
279	2026-04-26	2	3	1	\N	3	\N
280	2026-04-26	3	3	1	\N	2	\N
281	2026-03-16	1	1	1	\N	3	\N
282	2026-03-16	1	3	1	\N	4	\N
283	2026-03-16	2	3	1	\N	3	\N
284	2026-03-16	3	3	1	\N	2	\N
285	2026-03-17	1	1	1	\N	3	\N
286	2026-03-17	1	3	1	\N	4	\N
287	2026-03-17	2	3	1	\N	3	\N
288	2026-03-17	3	3	1	\N	2	\N
289	2026-03-18	1	1	1	\N	3	\N
290	2026-03-18	1	3	1	\N	4	\N
291	2026-03-18	2	3	1	\N	3	\N
292	2026-03-18	3	3	1	\N	2	\N
293	2026-03-19	1	1	1	\N	3	\N
294	2026-03-19	1	3	1	\N	4	\N
295	2026-03-19	2	3	1	\N	3	\N
296	2026-03-19	3	3	1	\N	2	\N
297	2026-03-20	1	1	1	\N	3	\N
298	2026-03-20	1	3	1	\N	4	\N
299	2026-03-20	2	3	1	\N	3	\N
300	2026-03-20	3	3	1	\N	2	\N
301	2026-03-21	1	1	1	\N	3	\N
302	2026-03-21	1	3	1	\N	4	\N
303	2026-03-21	2	3	1	\N	3	\N
304	2026-03-21	3	3	1	\N	2	\N
305	2026-03-22	1	1	1	\N	3	\N
306	2026-03-22	1	3	1	\N	4	\N
307	2026-03-22	2	3	1	\N	3	\N
308	2026-03-22	3	3	1	\N	2	\N
\.


--
-- Data for Name: trong_so_uu_tien; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.trong_so_uu_tien (id, khoa, gia_tri) FROM stdin;
1	uu_tien_ca_ua_thich	4
3	cong_bang_chich_ngoai	5
4	cong_bang_cuoi_tuan	4
5	uu_tien_ca_quan_trong	3
6	han_che_ca_muon_sang	2
7	bat_buoc_chich_ngoai	1
2	phat_ca_tranh	4
8	Ưu tiên làm Sáng	3
\.


--
-- Data for Name: vai_tro; Type: TABLE DATA; Schema: public; Owner: lich_user
--

COPY public.vai_tro (id, ten_vai_tro) FROM stdin;
1	Bác sỹ
2	KTV
3	Lễ tân
\.


--
-- Name: ca_lam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.ca_lam_id_seq', 5, true);


--
-- Name: chi_nhanh_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.chi_nhanh_id_seq', 3, true);


--
-- Name: lich_chi_tiet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.lich_chi_tiet_id_seq', 1226, true);


--
-- Name: lich_tuan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.lich_tuan_id_seq', 42, true);


--
-- Name: mapping_nhom_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.mapping_nhom_id_seq', 10, true);


--
-- Name: ngay_nghi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.ngay_nghi_id_seq', 1, false);


--
-- Name: nhan_vien_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.nhan_vien_id_seq', 11, true);


--
-- Name: nhan_vien_trong_so_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.nhan_vien_trong_so_id_seq', 4, true);


--
-- Name: nhom_hien_thi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.nhom_hien_thi_id_seq', 5, true);


--
-- Name: nhu_cau_ca_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.nhu_cau_ca_id_seq', 308, true);


--
-- Name: trong_so_uu_tien_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.trong_so_uu_tien_id_seq', 8, true);


--
-- Name: vai_tro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lich_user
--

SELECT pg_catalog.setval('public.vai_tro_id_seq', 3, true);


--
-- Name: ca_lam ca_lam_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.ca_lam
    ADD CONSTRAINT ca_lam_pkey PRIMARY KEY (id);


--
-- Name: ca_lam ca_lam_ten_ca_key; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.ca_lam
    ADD CONSTRAINT ca_lam_ten_ca_key UNIQUE (ten_ca);


--
-- Name: chi_nhanh chi_nhanh_ma_chi_nhanh_key; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.chi_nhanh
    ADD CONSTRAINT chi_nhanh_ma_chi_nhanh_key UNIQUE (ma_chi_nhanh);


--
-- Name: chi_nhanh chi_nhanh_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.chi_nhanh
    ADD CONSTRAINT chi_nhanh_pkey PRIMARY KEY (id);


--
-- Name: lich_chi_tiet lich_chi_tiet_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_chi_tiet
    ADD CONSTRAINT lich_chi_tiet_pkey PRIMARY KEY (id);


--
-- Name: lich_tuan lich_tuan_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_tuan
    ADD CONSTRAINT lich_tuan_pkey PRIMARY KEY (id);


--
-- Name: mapping_nhom mapping_nhom_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.mapping_nhom
    ADD CONSTRAINT mapping_nhom_pkey PRIMARY KEY (id);


--
-- Name: ngay_nghi ngay_nghi_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.ngay_nghi
    ADD CONSTRAINT ngay_nghi_pkey PRIMARY KEY (id);


--
-- Name: nhan_vien_ca_tranh nhan_vien_ca_tranh_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_ca_tranh
    ADD CONSTRAINT nhan_vien_ca_tranh_pkey PRIMARY KEY (nhan_vien_id, ca_id);


--
-- Name: nhan_vien_ca_ua_thich nhan_vien_ca_ua_thich_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_ca_ua_thich
    ADD CONSTRAINT nhan_vien_ca_ua_thich_pkey PRIMARY KEY (nhan_vien_id, ca_id);


--
-- Name: nhan_vien_chi_nhanh nhan_vien_chi_nhanh_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_chi_nhanh
    ADD CONSTRAINT nhan_vien_chi_nhanh_pkey PRIMARY KEY (nhan_vien_id, chi_nhanh_id);


--
-- Name: nhan_vien nhan_vien_ma_nv_key; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien
    ADD CONSTRAINT nhan_vien_ma_nv_key UNIQUE (ma_nv);


--
-- Name: nhan_vien nhan_vien_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien
    ADD CONSTRAINT nhan_vien_pkey PRIMARY KEY (id);


--
-- Name: nhan_vien_trong_so nhan_vien_trong_so_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_trong_so
    ADD CONSTRAINT nhan_vien_trong_so_pkey PRIMARY KEY (id);


--
-- Name: nhan_vien_vai_tro nhan_vien_vai_tro_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_vai_tro
    ADD CONSTRAINT nhan_vien_vai_tro_pkey PRIMARY KEY (nhan_vien_id, vai_tro_id);


--
-- Name: nhom_hien_thi nhom_hien_thi_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhom_hien_thi
    ADD CONSTRAINT nhom_hien_thi_pkey PRIMARY KEY (id);


--
-- Name: nhom_hien_thi nhom_hien_thi_ten_nhom_key; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhom_hien_thi
    ADD CONSTRAINT nhom_hien_thi_ten_nhom_key UNIQUE (ten_nhom);


--
-- Name: nhu_cau_ca nhu_cau_ca_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhu_cau_ca
    ADD CONSTRAINT nhu_cau_ca_pkey PRIMARY KEY (id);


--
-- Name: trong_so_uu_tien trong_so_uu_tien_khoa_key; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.trong_so_uu_tien
    ADD CONSTRAINT trong_so_uu_tien_khoa_key UNIQUE (khoa);


--
-- Name: trong_so_uu_tien trong_so_uu_tien_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.trong_so_uu_tien
    ADD CONSTRAINT trong_so_uu_tien_pkey PRIMARY KEY (id);


--
-- Name: vai_tro vai_tro_pkey; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.vai_tro
    ADD CONSTRAINT vai_tro_pkey PRIMARY KEY (id);


--
-- Name: vai_tro vai_tro_ten_vai_tro_key; Type: CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.vai_tro
    ADD CONSTRAINT vai_tro_ten_vai_tro_key UNIQUE (ten_vai_tro);


--
-- Name: ix_ca_lam_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_ca_lam_id ON public.ca_lam USING btree (id);


--
-- Name: ix_chi_nhanh_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_chi_nhanh_id ON public.chi_nhanh USING btree (id);


--
-- Name: ix_lich_chi_tiet_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_lich_chi_tiet_id ON public.lich_chi_tiet USING btree (id);


--
-- Name: ix_lich_tuan_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_lich_tuan_id ON public.lich_tuan USING btree (id);


--
-- Name: ix_mapping_nhom_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_mapping_nhom_id ON public.mapping_nhom USING btree (id);


--
-- Name: ix_ngay_nghi_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_ngay_nghi_id ON public.ngay_nghi USING btree (id);


--
-- Name: ix_nhan_vien_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_nhan_vien_id ON public.nhan_vien USING btree (id);


--
-- Name: ix_nhan_vien_trong_so_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_nhan_vien_trong_so_id ON public.nhan_vien_trong_so USING btree (id);


--
-- Name: ix_nhom_hien_thi_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_nhom_hien_thi_id ON public.nhom_hien_thi USING btree (id);


--
-- Name: ix_nhu_cau_ca_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_nhu_cau_ca_id ON public.nhu_cau_ca USING btree (id);


--
-- Name: ix_trong_so_uu_tien_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_trong_so_uu_tien_id ON public.trong_so_uu_tien USING btree (id);


--
-- Name: ix_vai_tro_id; Type: INDEX; Schema: public; Owner: lich_user
--

CREATE INDEX ix_vai_tro_id ON public.vai_tro USING btree (id);


--
-- Name: lich_chi_tiet lich_chi_tiet_ca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_chi_tiet
    ADD CONSTRAINT lich_chi_tiet_ca_id_fkey FOREIGN KEY (ca_id) REFERENCES public.ca_lam(id) ON DELETE SET NULL;


--
-- Name: lich_chi_tiet lich_chi_tiet_chi_nhanh_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_chi_tiet
    ADD CONSTRAINT lich_chi_tiet_chi_nhanh_id_fkey FOREIGN KEY (chi_nhanh_id) REFERENCES public.chi_nhanh(id) ON DELETE SET NULL;


--
-- Name: lich_chi_tiet lich_chi_tiet_lich_tuan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_chi_tiet
    ADD CONSTRAINT lich_chi_tiet_lich_tuan_id_fkey FOREIGN KEY (lich_tuan_id) REFERENCES public.lich_tuan(id) ON DELETE CASCADE;


--
-- Name: lich_chi_tiet lich_chi_tiet_nhan_vien_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_chi_tiet
    ADD CONSTRAINT lich_chi_tiet_nhan_vien_id_fkey FOREIGN KEY (nhan_vien_id) REFERENCES public.nhan_vien(id) ON DELETE CASCADE;


--
-- Name: lich_chi_tiet lich_chi_tiet_nhom_hien_thi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.lich_chi_tiet
    ADD CONSTRAINT lich_chi_tiet_nhom_hien_thi_id_fkey FOREIGN KEY (nhom_hien_thi_id) REFERENCES public.nhom_hien_thi(id) ON DELETE SET NULL;


--
-- Name: mapping_nhom mapping_nhom_ca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.mapping_nhom
    ADD CONSTRAINT mapping_nhom_ca_id_fkey FOREIGN KEY (ca_id) REFERENCES public.ca_lam(id) ON DELETE CASCADE;


--
-- Name: mapping_nhom mapping_nhom_chi_nhanh_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.mapping_nhom
    ADD CONSTRAINT mapping_nhom_chi_nhanh_id_fkey FOREIGN KEY (chi_nhanh_id) REFERENCES public.chi_nhanh(id) ON DELETE CASCADE;


--
-- Name: mapping_nhom mapping_nhom_nhom_hien_thi_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.mapping_nhom
    ADD CONSTRAINT mapping_nhom_nhom_hien_thi_id_fkey FOREIGN KEY (nhom_hien_thi_id) REFERENCES public.nhom_hien_thi(id) ON DELETE CASCADE;


--
-- Name: ngay_nghi ngay_nghi_nhan_vien_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.ngay_nghi
    ADD CONSTRAINT ngay_nghi_nhan_vien_id_fkey FOREIGN KEY (nhan_vien_id) REFERENCES public.nhan_vien(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_ca_tranh nhan_vien_ca_tranh_ca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_ca_tranh
    ADD CONSTRAINT nhan_vien_ca_tranh_ca_id_fkey FOREIGN KEY (ca_id) REFERENCES public.ca_lam(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_ca_tranh nhan_vien_ca_tranh_nhan_vien_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_ca_tranh
    ADD CONSTRAINT nhan_vien_ca_tranh_nhan_vien_id_fkey FOREIGN KEY (nhan_vien_id) REFERENCES public.nhan_vien(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_ca_ua_thich nhan_vien_ca_ua_thich_ca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_ca_ua_thich
    ADD CONSTRAINT nhan_vien_ca_ua_thich_ca_id_fkey FOREIGN KEY (ca_id) REFERENCES public.ca_lam(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_ca_ua_thich nhan_vien_ca_ua_thich_nhan_vien_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_ca_ua_thich
    ADD CONSTRAINT nhan_vien_ca_ua_thich_nhan_vien_id_fkey FOREIGN KEY (nhan_vien_id) REFERENCES public.nhan_vien(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_chi_nhanh nhan_vien_chi_nhanh_chi_nhanh_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_chi_nhanh
    ADD CONSTRAINT nhan_vien_chi_nhanh_chi_nhanh_id_fkey FOREIGN KEY (chi_nhanh_id) REFERENCES public.chi_nhanh(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_chi_nhanh nhan_vien_chi_nhanh_nhan_vien_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_chi_nhanh
    ADD CONSTRAINT nhan_vien_chi_nhanh_nhan_vien_id_fkey FOREIGN KEY (nhan_vien_id) REFERENCES public.nhan_vien(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_trong_so nhan_vien_trong_so_nhan_vien_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_trong_so
    ADD CONSTRAINT nhan_vien_trong_so_nhan_vien_id_fkey FOREIGN KEY (nhan_vien_id) REFERENCES public.nhan_vien(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_trong_so nhan_vien_trong_so_trong_so_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_trong_so
    ADD CONSTRAINT nhan_vien_trong_so_trong_so_id_fkey FOREIGN KEY (trong_so_id) REFERENCES public.trong_so_uu_tien(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_vai_tro nhan_vien_vai_tro_nhan_vien_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_vai_tro
    ADD CONSTRAINT nhan_vien_vai_tro_nhan_vien_id_fkey FOREIGN KEY (nhan_vien_id) REFERENCES public.nhan_vien(id) ON DELETE CASCADE;


--
-- Name: nhan_vien_vai_tro nhan_vien_vai_tro_vai_tro_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhan_vien_vai_tro
    ADD CONSTRAINT nhan_vien_vai_tro_vai_tro_id_fkey FOREIGN KEY (vai_tro_id) REFERENCES public.vai_tro(id) ON DELETE CASCADE;


--
-- Name: nhu_cau_ca nhu_cau_ca_ca_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhu_cau_ca
    ADD CONSTRAINT nhu_cau_ca_ca_id_fkey FOREIGN KEY (ca_id) REFERENCES public.ca_lam(id) ON DELETE CASCADE;


--
-- Name: nhu_cau_ca nhu_cau_ca_chi_nhanh_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhu_cau_ca
    ADD CONSTRAINT nhu_cau_ca_chi_nhanh_id_fkey FOREIGN KEY (chi_nhanh_id) REFERENCES public.chi_nhanh(id) ON DELETE SET NULL;


--
-- Name: nhu_cau_ca nhu_cau_ca_vai_tro_yeu_cau_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lich_user
--

ALTER TABLE ONLY public.nhu_cau_ca
    ADD CONSTRAINT nhu_cau_ca_vai_tro_yeu_cau_id_fkey FOREIGN KEY (vai_tro_yeu_cau_id) REFERENCES public.vai_tro(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict emNKN9hoy80NUpmcru9TgW9LMYpZv3SLfPIAzolYf7v8A4drfaXYnZU8bXck2no

