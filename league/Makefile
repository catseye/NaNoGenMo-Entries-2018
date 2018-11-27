SEED?=17
#ONLY=--generate-scenarios=Scene_650_filler
#DEBUG=--debug

all: build/novel.html
	wc -w build/novel.md

build/events.json: Extraordinarily-Dull.samovar
	samovar Extraordinarily-Dull.samovar \
	    --seed=$(SEED) --min-events=40 --max-events=10000 --verbose --lengthen-factor=1.5 $(ONLY) $(DEBUG) \
	    --output-type=events-json > build/events.json

build/novel.md: build/events.json
	python3 producer.py < build/events.json > build/novel.md

build/novel.html: build/novel.md
	echo '<!DOCTYPE html><html><head><meta charset="utf-8"><title>The League of Extraordinarily Dull Gentlemen</title></head><body>' > build/novel.html
	pandoc --from=markdown --to=html5 < build/novel.md >> build/novel.html

clean:
	rm -f build/*
