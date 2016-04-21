.PHONY: figures

figures:
	make -C experiments/throughput-sweep/

out/paper.pdf: paper.md figures
	docker run \
	  --rm \
	  --workdir="/root" \
	  -v `pwd`/experiments/:/root/experiments \
	  -v `pwd`/vendor/:/root/.pandoc/templates \
	  -v `pwd`/vendor/:/root/texmf/tex/latex \
	  -v `pwd`/paper.md:/root/paper.md \
	  -v `pwd`/out:/root/out \
	  ivotron/pandoc:1.13.2 \
	    --standalone \
	    --highlight-style tango \
	    --output=out/paper.pdf paper.md
		# 2> build.log
	    #--filter pandoc-citeproc
	#chown $(USER): $@