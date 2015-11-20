EBIN_PATH = ./ebin

compile:
	rebar compile

erl:
	erl -pa ebin/

pre:
	make compile
	erl -noshell -pa ${EBIN_PATH} \
	-eval 'record_util:make().'   \
	-eval 'halt().'

test:
	make pre
	make compile
	erl -noshell -pa ${EBIN_PATH} \
	-eval 'test:test().'          \
	-eval 'halt().'

