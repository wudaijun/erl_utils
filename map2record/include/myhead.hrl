-ifndef(HERO_PB_H).
-define(HERO_PB_H, true).
-record(hero, {
    hero_id = erlang:error({required, hero_id}),
    hero_base = erlang:error({required, hero_base}),
    hero_skill = []
}).
-endif.

-ifndef(HERO_BASE_PB_H).
-define(HERO_BASE_PB_H, true).
-record(hero_base, {
    hero_name = erlang:error({required, hero_name}),
    hero_level = erlang:error({required, hero_level}),
    hero_star = erlang:error({required, hero_star})
}).
-endif.

-ifndef(HERO_SKILL_PB_H).
-define(HERO_SKILL_PB_H, true).
-record(hero_skill, {
    skill_id = erlang:error({required, skill_id}),
    skill_lv = erlang:error({required, skill_lv})
}).
-endif.

