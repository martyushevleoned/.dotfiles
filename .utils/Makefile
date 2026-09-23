CFLAGS += -std=c11 -pedantic -Wall -Wextra
CXXFLAGS += -std=c++11 -pedantic -Wall -Wextra

.PHONY: all clean

all: \
	$(patsubst src/%.c, bin/%, $(wildcard src/*.c)) \
	$(patsubst src/%.cpp, bin/%, $(wildcard src/*.cpp)) \
	$(patsubst src/%.sh, bin/%, $(wildcard src/*.sh))

bin:
	mkdir -p bin

bin/%: src/%.c | bin
	$(CC) $(CFLAGS) -o $@ $<

bin/%: src/%.cpp | bin
	$(CXX) $(CXXFLAGS) -o $@ $<

bin/%: src/%.sh | bin
	cp $< $@

clean:
	rm -r bin
