-module(map2record).

-export([auto_transfer/2]).

auto_transfer(RecordName, MapData) ->
  case {myhead_util:is_record(RecordName), is_list(MapData)} of
    {true, true} ->
      lists:map(fun(SubData) ->
        auto_transfer(RecordName, SubData)
      end, MapData);
    {true, false} ->
      Fields = myhead_util:fields_info(RecordName),
      Values = lists:map(fun(Field) ->
        auto_transfer(Field, maps:get(Field, MapData, undefined))
      end, Fields),
      list_to_tuple([RecordName|Values]);
    {false, _} ->
      MapData 
  end.

