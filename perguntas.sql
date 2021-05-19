-- Quantidade de horas consumidas e plays por categoria
SELECT 
	coalesce(c.categoria, 'não definida') as categoria,
	sum(play.horas_consumidas) as qtd_horas_consumidas,
	count(play.*) as qtd_plays
FROM public.consumo play
LEFT JOIN public.conteudo c on c.id_conteudo = play.id_conteudo
GROUP BY  coalesce(c.categoria, 'não definida')

-- Ranking de novelas com mais horas consumidas por mês
SELECT 
	coalesce(c.categoria, 'não definida') as categoria,
	coalesce(c.conteudo, 'não definido') as conteudo,
	extract(year FROM play.data) as ano,
	extract(month FROM play.data) as mes,
	sum(play.horas_consumidas) as qtd_horas_consumidas
FROM public.consumo play
LEFT JOIN public.conteudo c on c.id_conteudo = play.id_conteudo
WHERE c.categoria = 'novela'
GROUP BY  categoria, conteudo, ano, mes
ORDER BY  sum(play.horas_consumidas) desc

-- Conteúdo de primeiro play do usuário
SELECT 
	DISTINCT
	play.id_user,
	(SELECT 
   		concat(coalesce(c2.categoria, ''), '-', coalesce(c2.conteudo, ''))
   FROM public.consumo play2
   LEFT JOIN public.conteudo c2 on c2.id_conteudo = play2.id_conteudo
   WHERE play2.id_user = play.id_user
   ORDER BY  play2.id_user, play2.data asc
   LIMIT 1) as primeiro_play
FROM public.consumo play
ORDER BY  play.id_user



SELECT 
	DISTINCT
	play.id_user,
	play2.conteudo as primeiro_play,
  play2.data  
FROM public.consumo play
LEFT JOIN (
   SELECT 
   		play2.id_user,
  		concat(coalesce(c2.categoria, ''), '-', coalesce(c2.conteudo, '')) as conteudo,
  		to_char(play2.data, 'dd/mm/yyyy') as data
   FROM public.consumo play2
   LEFT JOIN public.conteudo c2 on c2.id_conteudo = play2.id_conteudo
   ORDER BY  play2.id_user, play2.data asc
) as play2 on play2.id_user = play.id_user
ORDER BY  play.id_user

-- Minutos por play para cada usuário
SELECT 
	play.id_user,
	coalesce(c.categoria, 'não definida') as categoria,
	coalesce(c.conteudo, 'não definido') as conteudo,
	play.data,
	((horas * 60) + minutos) as qtd_minutos
FROM (
  SELECT
    id_user,
    id_conteudo,
    to_char(consumo.data, 'dd/mm/yyyy') as data,
  	horas_consumidas,
    cast(horas_consumidas as character varying(10)) as str_horas_consumidas,
    cast(substr(cast(horas_consumidas as character varying(10)), 1, strpos(cast(horas_consumidas as character varying(10)), '.')-1) as integer) as horas,
    cast(substr(cast(horas_consumidas as character varying(10)), strpos(cast(horas_consumidas as character varying(10)), '.')+1, length(cast(horas_consumidas as character varying(10)))) as integer) as minutos
  FROM public.consumo
) as play
LEFT JOIN public.conteudo c on c.id_conteudo = play.id_conteudo
ORDER BY  play.id_user, data

-- Qual a categoria mais consumida para cada usuário
SELECT 
	DISTINCT
	play.id_user,
  	(SELECT 
   		coalesce(c2.categoria, 'não definida') as categoria
	FROM public.consumo play2
	LEFT JOIN public.conteudo c2 on c2.id_conteudo = play2.id_conteudo
	WHERE play2.id_user = play.id_user
	GROUP BY  play2.id_user, coalesce(c2.categoria, 'não definida')
	ORDER BY  play2.id_user, sum(play2.horas_consumidas) desc
	LIMIT 1) as categoria_maior_consumo
FROM public.consumo play
ORDER BY  play.id_user


SELECT 
	DISTINCT
	play.id_user,
	play2.categoria as categoria_maior_consumo,
  play2.qtd_consumo  
FROM public.consumo play
LEFT JOIN (
   SELECT 
   		play2.id_user,
  		coalesce(c2.categoria, 'não definida') as categoria,
  		sum(play2.horas_consumidas) as qtd_consumo
   FROM public.consumo play2
   LEFT JOIN public.conteudo c2 on c2.id_conteudo = play2.id_conteudo
   GROUP BY  play2.id_user, coalesce(c2.categoria, 'não definida')
   ORDER BY  play2.id_user, sum(play2.horas_consumidas) desc
) as play2 on play2.id_user = play.id_user
ORDER BY  play.id_user

-- Conte uma história com os dados! Não precisa ser nada complexo. O objetivo é entendermos como você lida com informações e as analisa.

