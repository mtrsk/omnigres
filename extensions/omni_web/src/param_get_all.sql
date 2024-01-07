create function param_get_all(params params, param text) returns setof text
    strict immutable
as
$$
select
    params[i + 1] as value
from
    unnest(params) with ordinality t(v, i)
where
    v = param and
    i % 2 = 1
order by
    i asc;
$$
    language sql;

create function param_get_all(params text, param text) returns setof text
    strict immutable
as
$$
select omni_web.param_get_all(omni_web.parse_query_string(params), param);
$$
    language sql;

create function param_get_all(params bytea, param text) returns setof text
    strict immutable
as
$$
select omni_web.param_get_all(omni_web.parse_query_string(convert_from(params, 'UTF8')), param);
$$
    language sql;
