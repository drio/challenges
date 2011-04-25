bin=urlstuff

all: urlstuff

urlstuff: urlstuff.c khash.h
	gcc -o $(bin) urlstuff.c

test: urlstuff
	@echo -e "TEST1 (two keys)\n-------------"
	@echo "http://www.foofoofoo.com?embedCode=abc?foo=bar..." | ./$(bin)
	@echo -e "TEST2 (one key)\n--------------"
	@echo "http://www.foofoofoo.com?embedCode=abc" | ./$(bin)
	@echo -e "TEST3 (full input)\n-------------"
	@cat ../README | ./$(bin)

clean:
	rm -f $(bin)
