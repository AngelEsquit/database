--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2

-- Started on 2025-04-06 22:56:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 236 (class 1259 OID 90566)
-- Name: antecedentes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.antecedentes (
    id integer NOT NULL,
    paciente_id integer NOT NULL,
    medicos character varying,
    familiares character varying,
    oculares character varying,
    alergicos character varying,
    otros character varying
);


ALTER TABLE public.antecedentes OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 90565)
-- Name: antecedentes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.antecedentes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.antecedentes_id_seq OWNER TO postgres;

--
-- TOC entry 5077 (class 0 OID 0)
-- Dependencies: 235
-- Name: antecedentes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.antecedentes_id_seq OWNED BY public.antecedentes.id;


--
-- TOC entry 220 (class 1259 OID 90462)
-- Name: citas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citas (
    id integer NOT NULL,
    paciente_id integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    duracion time without time zone DEFAULT '00:20:00'::time without time zone NOT NULL,
    nombre character varying
);


ALTER TABLE public.citas OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 90461)
-- Name: citas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citas_id_seq OWNER TO postgres;

--
-- TOC entry 5078 (class 0 OID 0)
-- Dependencies: 219
-- Name: citas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citas_id_seq OWNED BY public.citas.id;


--
-- TOC entry 224 (class 1259 OID 90483)
-- Name: consultas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultas (
    id integer NOT NULL,
    paciente_id integer NOT NULL,
    motivo character varying DEFAULT 'Consulta General'::character varying NOT NULL,
    cuestionario_id integer,
    fecha date NOT NULL
);


ALTER TABLE public.consultas OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 90482)
-- Name: consultas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consultas_id_seq OWNER TO postgres;

--
-- TOC entry 5079 (class 0 OID 0)
-- Dependencies: 223
-- Name: consultas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultas_id_seq OWNED BY public.consultas.id;


--
-- TOC entry 238 (class 1259 OID 90580)
-- Name: consultas_preguntas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.consultas_preguntas (
    id integer NOT NULL,
    consulta_id integer NOT NULL,
    pregunta_id integer NOT NULL,
    valor_texto character varying,
    valor_entero integer,
    valor_booleano boolean,
    comentario character varying(150),
    valores_textos character varying[],
    valores_enteros integer[],
    valores_booleanos boolean[],
    CONSTRAINT check_booleanos_max2 CHECK (((array_length(valores_booleanos, 1) IS NULL) OR (array_length(valores_booleanos, 1) <= 2))),
    CONSTRAINT check_enteros_max2 CHECK (((array_length(valores_enteros, 1) IS NULL) OR (array_length(valores_enteros, 1) <= 2))),
    CONSTRAINT check_textos_max2 CHECK (((array_length(valores_textos, 1) IS NULL) OR (array_length(valores_textos, 1) <= 2)))
);


ALTER TABLE public.consultas_preguntas OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 90579)
-- Name: consultas_preguntas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.consultas_preguntas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.consultas_preguntas_id_seq OWNER TO postgres;

--
-- TOC entry 5080 (class 0 OID 0)
-- Dependencies: 237
-- Name: consultas_preguntas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.consultas_preguntas_id_seq OWNED BY public.consultas_preguntas.id;


--
-- TOC entry 232 (class 1259 OID 90539)
-- Name: cuestionarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cuestionarios (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    version character varying NOT NULL,
    activo boolean DEFAULT false NOT NULL
);


ALTER TABLE public.cuestionarios OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 90538)
-- Name: cuestionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cuestionarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuestionarios_id_seq OWNER TO postgres;

--
-- TOC entry 5081 (class 0 OID 0)
-- Dependencies: 231
-- Name: cuestionarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cuestionarios_id_seq OWNED BY public.cuestionarios.id;


--
-- TOC entry 222 (class 1259 OID 90474)
-- Name: diagnosticos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagnosticos (
    id integer NOT NULL,
    recomendacion character varying,
    nombre character varying NOT NULL,
    consulta_id integer NOT NULL
);


ALTER TABLE public.diagnosticos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 90473)
-- Name: diagnosticos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diagnosticos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diagnosticos_id_seq OWNER TO postgres;

--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 221
-- Name: diagnosticos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diagnosticos_id_seq OWNED BY public.diagnosticos.id;


--
-- TOC entry 228 (class 1259 OID 90511)
-- Name: examenes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.examenes (
    id integer NOT NULL,
    paciente_id integer NOT NULL,
    consulta_id integer,
    tipo character varying NOT NULL,
    fecha date,
    ruta_archivo character varying
);


ALTER TABLE public.examenes OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 90510)
-- Name: examenes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.examenes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.examenes_id_seq OWNER TO postgres;

--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 227
-- Name: examenes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.examenes_id_seq OWNED BY public.examenes.id;


--
-- TOC entry 254 (class 1259 OID 90715)
-- Name: horarios_especiales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horarios_especiales (
    id integer NOT NULL,
    fecha date NOT NULL,
    hora_apertura time without time zone NOT NULL,
    hora_cierre time without time zone NOT NULL
);


ALTER TABLE public.horarios_especiales OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 90714)
-- Name: horarios_especiales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.horarios_especiales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.horarios_especiales_id_seq OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 253
-- Name: horarios_especiales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.horarios_especiales_id_seq OWNED BY public.horarios_especiales.id;


--
-- TOC entry 256 (class 1259 OID 90722)
-- Name: horarios_laborales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.horarios_laborales (
    id integer NOT NULL,
    hora_apertura time without time zone NOT NULL,
    hora_cierre time without time zone NOT NULL,
    dia_semana integer NOT NULL
);


ALTER TABLE public.horarios_laborales OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 90721)
-- Name: horarios_laborales_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.horarios_laborales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.horarios_laborales_id_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 255
-- Name: horarios_laborales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.horarios_laborales_id_seq OWNED BY public.horarios_laborales.id;


--
-- TOC entry 252 (class 1259 OID 90701)
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    accion character varying NOT NULL,
    objeto character varying NOT NULL,
    objeto_id integer NOT NULL,
    fecha_hora timestamp without time zone NOT NULL
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 90700)
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_id_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 251
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- TOC entry 218 (class 1259 OID 90453)
-- Name: pacientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pacientes (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    fecha_nacimiento date NOT NULL,
    telefono character varying,
    sexo character varying NOT NULL
);


ALTER TABLE public.pacientes OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 90452)
-- Name: pacientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pacientes_id_seq OWNER TO postgres;

--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 217
-- Name: pacientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacientes_id_seq OWNED BY public.pacientes.id;


--
-- TOC entry 246 (class 1259 OID 90658)
-- Name: permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permisos (
    id integer NOT NULL,
    name character varying NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE public.permisos OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 90657)
-- Name: permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permisos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permisos_id_seq OWNER TO postgres;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 245
-- Name: permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permisos_id_seq OWNED BY public.permisos.id;


--
-- TOC entry 230 (class 1259 OID 90530)
-- Name: preguntas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preguntas (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    tipo character varying NOT NULL,
    bilaterial boolean NOT NULL
);


ALTER TABLE public.preguntas OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 90549)
-- Name: preguntas_cuestionarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preguntas_cuestionarios (
    id integer NOT NULL,
    cuestionario_id integer NOT NULL,
    pregunta_id integer NOT NULL,
    orden integer NOT NULL
);


ALTER TABLE public.preguntas_cuestionarios OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 90548)
-- Name: preguntas_cuestionarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preguntas_cuestionarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preguntas_cuestionarios_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 233
-- Name: preguntas_cuestionarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preguntas_cuestionarios_id_seq OWNED BY public.preguntas_cuestionarios.id;


--
-- TOC entry 229 (class 1259 OID 90529)
-- Name: preguntas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.preguntas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preguntas_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 229
-- Name: preguntas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.preguntas_id_seq OWNED BY public.preguntas.id;


--
-- TOC entry 244 (class 1259 OID 90649)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying NOT NULL,
    descripcion character varying NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 90648)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 243
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 250 (class 1259 OID 90684)
-- Name: roles_permisos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles_permisos (
    id integer NOT NULL,
    rol_id integer NOT NULL,
    permiso_id integer NOT NULL
);


ALTER TABLE public.roles_permisos OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 90683)
-- Name: roles_permisos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_permisos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_permisos_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 249
-- Name: roles_permisos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_permisos_id_seq OWNED BY public.roles_permisos.id;


--
-- TOC entry 226 (class 1259 OID 90502)
-- Name: tratamientos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tratamientos (
    id integer NOT NULL,
    componente_activo character varying NOT NULL,
    presentacion character varying NOT NULL,
    dosificacion double precision NOT NULL,
    tiempo interval NOT NULL,
    frecuencia interval NOT NULL,
    diagnostico_id integer NOT NULL
);


ALTER TABLE public.tratamientos OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 90501)
-- Name: tratamientos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tratamientos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tratamientos_id_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 225
-- Name: tratamientos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tratamientos_id_seq OWNED BY public.tratamientos.id;


--
-- TOC entry 240 (class 1259 OID 90626)
-- Name: tutores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tutores (
    id integer NOT NULL,
    paciente_id integer NOT NULL,
    nombre character varying NOT NULL,
    telefono character varying NOT NULL,
    parentesco character varying NOT NULL,
    es_contacto_principal boolean NOT NULL
);


ALTER TABLE public.tutores OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 90625)
-- Name: tutores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tutores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tutores_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 239
-- Name: tutores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tutores_id_seq OWNED BY public.tutores.id;


--
-- TOC entry 242 (class 1259 OID 90640)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    username character varying NOT NULL,
    password_hash character varying NOT NULL,
    correo character varying NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 90639)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 241
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 248 (class 1259 OID 90667)
-- Name: usuarios_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios_roles (
    id integer NOT NULL,
    usuario_id integer NOT NULL,
    rol_id integer NOT NULL
);


ALTER TABLE public.usuarios_roles OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 90666)
-- Name: usuarios_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_roles_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 247
-- Name: usuarios_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_roles_id_seq OWNED BY public.usuarios_roles.id;


--
-- TOC entry 4802 (class 2604 OID 90569)
-- Name: antecedentes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antecedentes ALTER COLUMN id SET DEFAULT nextval('public.antecedentes_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 90465)
-- Name: citas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas ALTER COLUMN id SET DEFAULT nextval('public.citas_id_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 90486)
-- Name: consultas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas ALTER COLUMN id SET DEFAULT nextval('public.consultas_id_seq'::regclass);


--
-- TOC entry 4803 (class 2604 OID 90583)
-- Name: consultas_preguntas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas_preguntas ALTER COLUMN id SET DEFAULT nextval('public.consultas_preguntas_id_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 90542)
-- Name: cuestionarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios ALTER COLUMN id SET DEFAULT nextval('public.cuestionarios_id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 90477)
-- Name: diagnosticos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnosticos ALTER COLUMN id SET DEFAULT nextval('public.diagnosticos_id_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 90514)
-- Name: examenes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examenes ALTER COLUMN id SET DEFAULT nextval('public.examenes_id_seq'::regclass);


--
-- TOC entry 4811 (class 2604 OID 90718)
-- Name: horarios_especiales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horarios_especiales ALTER COLUMN id SET DEFAULT nextval('public.horarios_especiales_id_seq'::regclass);


--
-- TOC entry 4812 (class 2604 OID 90725)
-- Name: horarios_laborales id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horarios_laborales ALTER COLUMN id SET DEFAULT nextval('public.horarios_laborales_id_seq'::regclass);


--
-- TOC entry 4810 (class 2604 OID 90704)
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- TOC entry 4790 (class 2604 OID 90456)
-- Name: pacientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes ALTER COLUMN id SET DEFAULT nextval('public.pacientes_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 90661)
-- Name: permisos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos ALTER COLUMN id SET DEFAULT nextval('public.permisos_id_seq'::regclass);


--
-- TOC entry 4798 (class 2604 OID 90533)
-- Name: preguntas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas ALTER COLUMN id SET DEFAULT nextval('public.preguntas_id_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 90552)
-- Name: preguntas_cuestionarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas_cuestionarios ALTER COLUMN id SET DEFAULT nextval('public.preguntas_cuestionarios_id_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 90652)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 90687)
-- Name: roles_permisos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos ALTER COLUMN id SET DEFAULT nextval('public.roles_permisos_id_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 90505)
-- Name: tratamientos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos ALTER COLUMN id SET DEFAULT nextval('public.tratamientos_id_seq'::regclass);


--
-- TOC entry 4804 (class 2604 OID 90629)
-- Name: tutores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutores ALTER COLUMN id SET DEFAULT nextval('public.tutores_id_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 90643)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 90670)
-- Name: usuarios_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles ALTER COLUMN id SET DEFAULT nextval('public.usuarios_roles_id_seq'::regclass);


--
-- TOC entry 5051 (class 0 OID 90566)
-- Dependencies: 236
-- Data for Name: antecedentes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.antecedentes (id, paciente_id, medicos, familiares, oculares, alergicos, otros) FROM stdin;
\.


--
-- TOC entry 5035 (class 0 OID 90462)
-- Dependencies: 220
-- Data for Name: citas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.citas (id, paciente_id, fecha, duracion, nombre) FROM stdin;
\.


--
-- TOC entry 5039 (class 0 OID 90483)
-- Dependencies: 224
-- Data for Name: consultas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultas (id, paciente_id, motivo, cuestionario_id, fecha) FROM stdin;
\.


--
-- TOC entry 5053 (class 0 OID 90580)
-- Dependencies: 238
-- Data for Name: consultas_preguntas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.consultas_preguntas (id, consulta_id, pregunta_id, valor_texto, valor_entero, valor_booleano, comentario, valores_textos, valores_enteros, valores_booleanos) FROM stdin;
\.


--
-- TOC entry 5047 (class 0 OID 90539)
-- Dependencies: 232
-- Data for Name: cuestionarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cuestionarios (id, nombre, version, activo) FROM stdin;
\.


--
-- TOC entry 5037 (class 0 OID 90474)
-- Dependencies: 222
-- Data for Name: diagnosticos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagnosticos (id, recomendacion, nombre, consulta_id) FROM stdin;
\.


--
-- TOC entry 5043 (class 0 OID 90511)
-- Dependencies: 228
-- Data for Name: examenes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.examenes (id, paciente_id, consulta_id, tipo, fecha, ruta_archivo) FROM stdin;
\.


--
-- TOC entry 5069 (class 0 OID 90715)
-- Dependencies: 254
-- Data for Name: horarios_especiales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.horarios_especiales (id, fecha, hora_apertura, hora_cierre) FROM stdin;
\.


--
-- TOC entry 5071 (class 0 OID 90722)
-- Dependencies: 256
-- Data for Name: horarios_laborales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.horarios_laborales (id, hora_apertura, hora_cierre, dia_semana) FROM stdin;
\.


--
-- TOC entry 5067 (class 0 OID 90701)
-- Dependencies: 252
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (id, usuario_id, accion, objeto, objeto_id, fecha_hora) FROM stdin;
\.


--
-- TOC entry 5033 (class 0 OID 90453)
-- Dependencies: 218
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pacientes (id, nombre, fecha_nacimiento, telefono, sexo) FROM stdin;
\.


--
-- TOC entry 5061 (class 0 OID 90658)
-- Dependencies: 246
-- Data for Name: permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permisos (id, name, descripcion) FROM stdin;
\.


--
-- TOC entry 5045 (class 0 OID 90530)
-- Dependencies: 230
-- Data for Name: preguntas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preguntas (id, nombre, tipo, bilaterial) FROM stdin;
\.


--
-- TOC entry 5049 (class 0 OID 90549)
-- Dependencies: 234
-- Data for Name: preguntas_cuestionarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preguntas_cuestionarios (id, cuestionario_id, pregunta_id, orden) FROM stdin;
\.


--
-- TOC entry 5059 (class 0 OID 90649)
-- Dependencies: 244
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, nombre, descripcion) FROM stdin;
\.


--
-- TOC entry 5065 (class 0 OID 90684)
-- Dependencies: 250
-- Data for Name: roles_permisos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles_permisos (id, rol_id, permiso_id) FROM stdin;
\.


--
-- TOC entry 5041 (class 0 OID 90502)
-- Dependencies: 226
-- Data for Name: tratamientos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tratamientos (id, componente_activo, presentacion, dosificacion, tiempo, frecuencia, diagnostico_id) FROM stdin;
\.


--
-- TOC entry 5055 (class 0 OID 90626)
-- Dependencies: 240
-- Data for Name: tutores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tutores (id, paciente_id, nombre, telefono, parentesco, es_contacto_principal) FROM stdin;
\.


--
-- TOC entry 5057 (class 0 OID 90640)
-- Dependencies: 242
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, username, password_hash, correo) FROM stdin;
\.


--
-- TOC entry 5063 (class 0 OID 90667)
-- Dependencies: 248
-- Data for Name: usuarios_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios_roles (id, usuario_id, rol_id) FROM stdin;
\.


--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 235
-- Name: antecedentes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.antecedentes_id_seq', 1, false);


--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 219
-- Name: citas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.citas_id_seq', 1, false);


--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 223
-- Name: consultas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultas_id_seq', 1, false);


--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 237
-- Name: consultas_preguntas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.consultas_preguntas_id_seq', 1, false);


--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 231
-- Name: cuestionarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cuestionarios_id_seq', 1, false);


--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 221
-- Name: diagnosticos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diagnosticos_id_seq', 1, false);


--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 227
-- Name: examenes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.examenes_id_seq', 1, false);


--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 253
-- Name: horarios_especiales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horarios_especiales_id_seq', 1, false);


--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 255
-- Name: horarios_laborales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.horarios_laborales_id_seq', 1, false);


--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 251
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_id_seq', 1, false);


--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 217
-- Name: pacientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacientes_id_seq', 1, false);


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 245
-- Name: permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permisos_id_seq', 1, false);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 233
-- Name: preguntas_cuestionarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preguntas_cuestionarios_id_seq', 1, false);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 229
-- Name: preguntas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.preguntas_id_seq', 1, false);


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 243
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 1, false);


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 249
-- Name: roles_permisos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_permisos_id_seq', 1, false);


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 225
-- Name: tratamientos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tratamientos_id_seq', 1, false);


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 239
-- Name: tutores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tutores_id_seq', 1, false);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 241
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 1, false);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 247
-- Name: usuarios_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_roles_id_seq', 1, false);


--
-- TOC entry 4844 (class 2606 OID 90573)
-- Name: antecedentes antecedentes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antecedentes
    ADD CONSTRAINT antecedentes_pkey PRIMARY KEY (id);


--
-- TOC entry 4821 (class 2606 OID 90467)
-- Name: citas citas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_pkey PRIMARY KEY (id);


--
-- TOC entry 4825 (class 2606 OID 90490)
-- Name: consultas consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas
    ADD CONSTRAINT consultas_pkey PRIMARY KEY (id);


--
-- TOC entry 4848 (class 2606 OID 90587)
-- Name: consultas_preguntas consultas_preguntas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas_preguntas
    ADD CONSTRAINT consultas_preguntas_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 90547)
-- Name: cuestionarios cuestionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios
    ADD CONSTRAINT cuestionarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4823 (class 2606 OID 90481)
-- Name: diagnosticos diagnosticos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnosticos
    ADD CONSTRAINT diagnosticos_pkey PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 90518)
-- Name: examenes examenes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examenes
    ADD CONSTRAINT examenes_pkey PRIMARY KEY (id);


--
-- TOC entry 4866 (class 2606 OID 90720)
-- Name: horarios_especiales horarios_especiales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horarios_especiales
    ADD CONSTRAINT horarios_especiales_pkey PRIMARY KEY (id);


--
-- TOC entry 4868 (class 2606 OID 90729)
-- Name: horarios_laborales horarios_laborales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.horarios_laborales
    ADD CONSTRAINT horarios_laborales_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 90708)
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- TOC entry 4817 (class 2606 OID 90460)
-- Name: pacientes pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id);


--
-- TOC entry 4858 (class 2606 OID 90665)
-- Name: permisos permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permisos
    ADD CONSTRAINT permisos_pkey PRIMARY KEY (id);


--
-- TOC entry 4840 (class 2606 OID 90554)
-- Name: preguntas_cuestionarios preguntas_cuestionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas_cuestionarios
    ADD CONSTRAINT preguntas_cuestionarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4831 (class 2606 OID 90537)
-- Name: preguntas preguntas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT preguntas_pkey PRIMARY KEY (id);


--
-- TOC entry 4862 (class 2606 OID 90689)
-- Name: roles_permisos roles_permisos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_pkey PRIMARY KEY (id);


--
-- TOC entry 4856 (class 2606 OID 90656)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4827 (class 2606 OID 90509)
-- Name: tratamientos tratamientos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos
    ADD CONSTRAINT tratamientos_pkey PRIMARY KEY (id);


--
-- TOC entry 4852 (class 2606 OID 90633)
-- Name: tutores tutores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutores
    ADD CONSTRAINT tutores_pkey PRIMARY KEY (id);


--
-- TOC entry 4850 (class 2606 OID 90735)
-- Name: consultas_preguntas unique_consulta_pregunta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas_preguntas
    ADD CONSTRAINT unique_consulta_pregunta UNIQUE (consulta_id, pregunta_id);


--
-- TOC entry 4842 (class 2606 OID 90619)
-- Name: preguntas_cuestionarios unique_cuestionario_pregunta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas_cuestionarios
    ADD CONSTRAINT unique_cuestionario_pregunta UNIQUE (cuestionario_id, pregunta_id);


--
-- TOC entry 4833 (class 2606 OID 90621)
-- Name: preguntas unique_name_type; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas
    ADD CONSTRAINT unique_name_type UNIQUE (nombre, tipo);


--
-- TOC entry 4838 (class 2606 OID 90616)
-- Name: cuestionarios unique_nombre_version; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cuestionarios
    ADD CONSTRAINT unique_nombre_version UNIQUE (nombre, version);


--
-- TOC entry 4846 (class 2606 OID 90732)
-- Name: antecedentes unique_paciente_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antecedentes
    ADD CONSTRAINT unique_paciente_id UNIQUE (paciente_id);


--
-- TOC entry 4819 (class 2606 OID 90624)
-- Name: pacientes unique_phone; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT unique_phone UNIQUE (telefono);


--
-- TOC entry 4854 (class 2606 OID 90647)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4860 (class 2606 OID 90672)
-- Name: usuarios_roles usuarios_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT usuarios_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4836 (class 1259 OID 90745)
-- Name: idx_cuestionario_unico_activo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_cuestionario_unico_activo ON public.cuestionarios USING btree (nombre) WHERE (activo = true);


--
-- TOC entry 4878 (class 2606 OID 90574)
-- Name: antecedentes antecedentes_paciente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.antecedentes
    ADD CONSTRAINT antecedentes_paciente_id_fkey FOREIGN KEY (paciente_id) REFERENCES public.pacientes(id);


--
-- TOC entry 4869 (class 2606 OID 90468)
-- Name: citas citas_paciente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_paciente_id_fkey FOREIGN KEY (paciente_id) REFERENCES public.pacientes(id);


--
-- TOC entry 4871 (class 2606 OID 90610)
-- Name: consultas consultas_cuestionario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas
    ADD CONSTRAINT consultas_cuestionario_id_fkey FOREIGN KEY (cuestionario_id) REFERENCES public.cuestionarios(id);


--
-- TOC entry 4872 (class 2606 OID 90491)
-- Name: consultas consultas_paciente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas
    ADD CONSTRAINT consultas_paciente_id_fkey FOREIGN KEY (paciente_id) REFERENCES public.pacientes(id);


--
-- TOC entry 4879 (class 2606 OID 90588)
-- Name: consultas_preguntas consultas_preguntas_consulta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas_preguntas
    ADD CONSTRAINT consultas_preguntas_consulta_id_fkey FOREIGN KEY (consulta_id) REFERENCES public.consultas(id);


--
-- TOC entry 4880 (class 2606 OID 90593)
-- Name: consultas_preguntas consultas_preguntas_pregunta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.consultas_preguntas
    ADD CONSTRAINT consultas_preguntas_pregunta_id_fkey FOREIGN KEY (pregunta_id) REFERENCES public.preguntas(id);


--
-- TOC entry 4870 (class 2606 OID 90598)
-- Name: diagnosticos diagnosticos_consulta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnosticos
    ADD CONSTRAINT diagnosticos_consulta_id_fkey FOREIGN KEY (consulta_id) REFERENCES public.consultas(id);


--
-- TOC entry 4874 (class 2606 OID 90524)
-- Name: examenes examenes_consulta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examenes
    ADD CONSTRAINT examenes_consulta_id_fkey FOREIGN KEY (consulta_id) REFERENCES public.consultas(id);


--
-- TOC entry 4875 (class 2606 OID 90519)
-- Name: examenes examenes_paciente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.examenes
    ADD CONSTRAINT examenes_paciente_id_fkey FOREIGN KEY (paciente_id) REFERENCES public.pacientes(id);


--
-- TOC entry 4886 (class 2606 OID 90709)
-- Name: logs logs_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- TOC entry 4876 (class 2606 OID 90555)
-- Name: preguntas_cuestionarios preguntas_cuestionarios_cuestionario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas_cuestionarios
    ADD CONSTRAINT preguntas_cuestionarios_cuestionario_id_fkey FOREIGN KEY (cuestionario_id) REFERENCES public.cuestionarios(id);


--
-- TOC entry 4877 (class 2606 OID 90560)
-- Name: preguntas_cuestionarios preguntas_cuestionarios_pregunta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preguntas_cuestionarios
    ADD CONSTRAINT preguntas_cuestionarios_pregunta_id_fkey FOREIGN KEY (pregunta_id) REFERENCES public.preguntas(id);


--
-- TOC entry 4884 (class 2606 OID 90695)
-- Name: roles_permisos roles_permisos_permiso_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_permiso_id_fkey FOREIGN KEY (permiso_id) REFERENCES public.permisos(id);


--
-- TOC entry 4885 (class 2606 OID 90690)
-- Name: roles_permisos roles_permisos_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles_permisos
    ADD CONSTRAINT roles_permisos_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);


--
-- TOC entry 4873 (class 2606 OID 90603)
-- Name: tratamientos tratamientos_diagnostico_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratamientos
    ADD CONSTRAINT tratamientos_diagnostico_id_fkey FOREIGN KEY (diagnostico_id) REFERENCES public.diagnosticos(id);


--
-- TOC entry 4881 (class 2606 OID 90634)
-- Name: tutores tutores_paciente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tutores
    ADD CONSTRAINT tutores_paciente_id_fkey FOREIGN KEY (paciente_id) REFERENCES public.pacientes(id);


--
-- TOC entry 4882 (class 2606 OID 90678)
-- Name: usuarios_roles usuarios_roles_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT usuarios_roles_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);


--
-- TOC entry 4883 (class 2606 OID 90673)
-- Name: usuarios_roles usuarios_roles_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios_roles
    ADD CONSTRAINT usuarios_roles_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


-- Completed on 2025-04-06 22:56:38

--
-- PostgreSQL database dump complete
--

