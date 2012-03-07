LIBRARY=layout.scad

# Identify target output modules from ${LIBRARY}
// TARGETS=$(shell ls *.scad | grep -v ${LIBRARY} | sed 's/\.scad/\.stl/')
TARGETS=$(shell sed '/^module [a-z0-9_-]*().*OUTPUT.*$$/!d;s/module //;s/().*/.stl/' ${LIBRARY})
SCADS=$(shell sed '/^module [a-z0-9_-]*().*OUTPUT.*$$/!d;s/module //;s/().*/.scad/' ${LIBRARY})

all:	${TARGETS}

# auto-generated .scad files with .deps make make re-build always. keeping the
# scad files solves this problem. (explanations are welcome.)
.SECONDARY: $(shell echo "${TARGETS}" | sed 's/\.stl/.scad/g')

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard *.deps)

%.scad:
	echo -n 'use <${LIBRARY}>\n$(*F)();' > $@

%.stl:	%.scad
	openscad -m make -o $@ -d $@.deps $<

clean:
	rm -f *~ *.deps ${TARGETS} ${SCADS}

