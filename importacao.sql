CREATE TABLE public.conteudo
(
    id_conteudo SERIAL,
    conteudo character varying(2) COLLATE pg_catalog."default",
    categoria character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT conteudo_conteudo_key UNIQUE (conteudo),
    CONSTRAINT conteudo_pkey PRIMARY KEY (id_conteudo)
)

TABLESPACE pg_default;

ALTER TABLE public.conteudo
    OWNER to postgres;

	
INSERT INTO public.conteudo (id_conteudo, conteudo, categoria)
		VALUES
	(10406, 'A', 'novela'),
	(10352, 'B', 'serie'),
	(10206, 'C', 'novela'),
	(10835, 'D', 'serie');


------------------------------------------------
CREATE TABLE public.consumo
(
    id_user integer,
	id_conteudo integer,
    data timestamp without time zone,
    horas_consumidas numeric(10,2)
)

TABLESPACE pg_default;

ALTER TABLE public.consumo
    OWNER to postgres;
	



INSERT INTO consumo (id_user, id_conteudo, data, horas_consumidas)
		VALUES
(150, 10406, '2019-07-07 00:00:00', 0.27),
(139, 10352, '2019-11-24 00:00:00', 0.59),
(182, 10206, '2019-07-26 00:00:00', 0.82),
(199, 10835, '2019-11-10 00:00:00', 0.24),
(185, 10406, '2019-11-19 00:00:00', 0.98),
(144, 10777, '2019-11-09 00:00:00', 0.53),
(136, 10206, '2019-07-18 00:00:00', 0.07),
(150, 10835, '2019-07-09 00:00:00', 0.61),
(199, 10406, '2019-07-24 00:00:00', 0.70),
(182, 10352, '2019-08-08 00:00:00', 0.61),
(199, 10777, '2019-09-17 00:00:00', 0.42),
(185, 10835, '2019-07-21 00:00:00', 0.51),
(144, 10406, '2019-07-03 00:00:00', 0.16),
(136, 10352, '2019-10-09 00:00:00', 0.16),
(199, 10777, '2019-08-19 00:00:00', 0.82),
(185, 10835, '2019-11-07 00:00:00', 0.45),
(144, 10406, '2019-10-20 00:00:00', 0.38),
(182, 10352, '2019-11-27 00:00:00', 0.94),
(150, 10206, '2019-07-30 00:00:00', 0.13),
(144, 10835, '2019-08-15 00:00:00', 0.80),
(144, 10406, '2019-10-04 00:00:00', 0.20),
(136, 10352, '2019-11-02 00:00:00', 0.64),
(199, 10352, '2019-09-26 00:00:00', 0.54),
(185, 10352, '2019-11-13 00:00:00', 0.27),
(144, 10352, '2019-11-20 00:00:00', 0.92);
