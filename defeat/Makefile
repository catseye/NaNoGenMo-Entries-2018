all: build/novel.html
	wc -w build/novel.md

build/novel.md: defeat.jl
	julia defeat.jl > build/novel.md

build/novel.html: build/novel.md
	echo '<!DOCTYPE html><html><head><meta charset="utf-8"><title>The Defeat at Procyon V</title></head><body>' > build/novel.html
	pandoc --from=markdown --to=html5 < build/novel.md >> build/novel.html

clean:
	rm -f build/*
