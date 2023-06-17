init:
	@echo "ERROR: no Makefile target selected"
	@echo ""
	@echo "USAGE: make clean"
	@echo ""
	@echo "       make javafile=example.java build"
	@echo ""
	@echo "       make javafile=example.java run"
	@echo ""
	@exit 1

clean:
	@rm *.class || exit 0

build:
	@docker run -v ${PWD}:/hello -w /hello amazoncorretto:17.0.7-al2 javac $$javafile

run:
	@classfile=$$( echo $$javafile | cut -f 1 -d '.'); \
	docker run -v ${PWD}:/hello -w /hello amazoncorretto:17.0.7-al2 java $$classfile
