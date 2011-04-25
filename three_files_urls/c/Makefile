bin=urlstuff

all: urlstuff

urlstuff: urlstuff.c khash.h
	gcc -o $(bin) urlstuff.c

test: urlstuff
	@echo -e "* TEST1 (two keys)"
	@echo "http://www.foofoofoo.com?embedCode=abc?foo=bar..." | ./$(bin)
	@echo -e "* TEST2 (one key)"
	@echo "http://www.foofoofoo.com?embedCode=abc" | ./$(bin)
	@echo -e "* TEST3 (two keys same value)"
	@echo "http://www.foofoofoo.com?embedCode=abc&embedCode=abc" | ./$(bin)
	@echo -e "* TEST4 (full input)"
	@cat ../README | ./$(bin)

clean:
	rm -f $(bin)
