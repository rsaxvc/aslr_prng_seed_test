#needed for brace expansion below
SHELL := bash

#configure here
NUMSAMPLES=100000

statistics: aslr_test.runlog
	@echo -n "number of samples in run:"
	@wc -l $< | cut -d" " -f 1

	@echo -n "unique locations of malloc:"
	@cut -d" " -f 1 $< | sort | uniq | wc -l

	@echo -n "unique locations of printf:"
	@cut -d" " -f 2 $< | sort | uniq | wc -l

	@echo -n "unique results of malloc xor printf:"
	@cut -d" " -f 3 $< | sort | uniq | wc -l

	@echo "up to 10 most common counts and offsets between malloc and printf:"
	@cut -d" " -f 4 aslr_test.runlog  | sort | uniq -c | sort -n | tail

	@echo "up to 10 most common counts and values(hex) of malloc xor printf:"
	@cut -d" " -f3 $< | sort | uniq -c | sort -n | tail

aslr_sampler: aslr_sampler.c

aslr_test.runlog: aslr_sampler
	@echo "generating a lot of ASLR samples, please wait"
	@rm -f $@
	@set -e; for a in {1..${NUMSAMPLES}}; do ./$< >> $@; done

