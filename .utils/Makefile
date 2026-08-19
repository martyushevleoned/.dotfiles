.PHONY: all clean

all: \
	$(patsubst src/%.c, bin/%, $(wildcard src/*.c)) \
	$(patsubst src/%.cpp, bin/%, $(wildcard src/*.cpp))

bin:
	mkdir -p bin

bin/%: src/%.c | bin
	$(CC) $(CFLAGS) -o $@ $<

bin/%: src/%.cpp | bin
	$(CXX) $(CXXFLAGS) -o $@ $<

clean:
	rm -r bin
