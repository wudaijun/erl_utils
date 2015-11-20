% From: https://github.com/jixiuf/helloerlang/blob/master/record_field/src/record_util.erl

-module(record_util).
%% -include("myhead.hrl").
-define(HEAD_FILE_PATH,"include/myhead.hrl").%relative to ebin/
%% save ?MODULENAME.erl in this dir
-define(DEST_DIR,"src/").                     %relative to ebin/
-define(MODULENAME,"myhead_util").
-define(INCLUDE_CMD_IN_DEST_MODULE,"-include(\"myhead.hrl\").").

-export([make/0]).


make() ->
    {ok,Tree}=epp:parse_file(?HEAD_FILE_PATH,["./"],[]),
    Src=make_src(Tree),
    ok=file:write_file(filename:join([?DEST_DIR,?MODULENAME])++".erl",list_to_binary(Src)).

make_src(Tree) -> make_src(Tree,[]).

make_src([],Acc)                              ->
    top_and_tail([make_info(Acc,[]),
                  "\n",
                  make_is_record(Acc,[])
                ]);
make_src([{attribute,_,record,Record}|T],Acc) -> make_src(T,[Record|Acc]);
make_src([_H|T],Acc)                          -> make_src(T,Acc).

make_info([],Acc1)->
    Head="%% get all field name of a record\n",
    Tail1="fields_info(_Other) -> exit({error,\"Invalid Record Name\"}).\n",
    [Head|lists:reverse([Tail1|Acc1])];
make_info([{RecName,Def}|T],Acc1)->
    Fields=lists:map(fun(RecordField)->                   %{record_field,3,{atom,3,name}},or {record_field,2,{atom,2,classe},{string,2,"asdf"}}
                             {atom,_Index,Field}=element(3,RecordField),
                             Field
                     end ,Def),
        %% [F|| {record_field,_Num,{atom,_Num2,F}} <- Def ],
    Cause= "fields_info("++atom_to_list(RecName)++") -> "++
           io_lib:format("~p",[Fields])++";\n"++
        "fields_info(Record ) when is_record(Record,"++atom_to_list(RecName)++")->"++
           io_lib:format("~p",[Fields])++";\n",
    make_info(T,[Cause|Acc1])
    .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
make_is_record([],Acc1)->
    lists:reverse(["is_record(_)->false.\n"|Acc1]);
make_is_record([{RecName,_Def}|T],Acc1)->
    Cause="is_record("++atom_to_list(RecName)++ ") -> true;\n",
    make_is_record(T,[Cause|Acc1])
    .
top_and_tail(Acc1)->
    Top="%% This module automatically generated - do not edit\n"++
    "\n"++
    "-module("++?MODULENAME++").\n"++
    "\n"++
    ?INCLUDE_CMD_IN_DEST_MODULE++
    "\n"++
    "-export([fields_info/1,is_record/1]).\n"++
    "\n",
    %% Tail1="length(Other) -> exit({error,\"Invalid Record Name: \""++
    %% "++Other}).\n\n\n",
    Top++lists:flatten(Acc1).
