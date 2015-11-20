%% This module automatically generated - do not edit

-module(myhead_util).

-include("myhead.hrl").
-export([fields_info/1,is_record/1]).

%% get all field name of a record
fields_info(hero_skill) -> [skill_id,skill_lv];
fields_info(Record ) when is_record(Record,hero_skill)->[skill_id,skill_lv];
fields_info(hero_base) -> [hero_name,hero_level,hero_star];
fields_info(Record ) when is_record(Record,hero_base)->[hero_name,hero_level,hero_star];
fields_info(hero) -> [hero_id,hero_base,hero_skill];
fields_info(Record ) when is_record(Record,hero)->[hero_id,hero_base,hero_skill];
fields_info(_Other) -> exit({error,"Invalid Record Name"}).

is_record(hero_skill) -> true;
is_record(hero_base) -> true;
is_record(hero) -> true;
is_record(_)->false.
