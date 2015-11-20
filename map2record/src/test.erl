-module(test).
-export([test/0]).

test() ->
  HeroMap = #{hero_id => 1, 
              hero_base => #{
                    hero_name  => "jack",
                    hero_level => 2,
                    hero_star  => 3},
              hero_skill  => [
                    #{
                      skill_id => 1,
                      skill_lv => 1
                    },
                    #{
                      skill_id => 2,
                      skill_lv => 2
                    }
                  ]},
  map2record:auto_transfer(hero, HeroMap).
