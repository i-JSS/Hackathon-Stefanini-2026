COBC = cobc
SRC = src
BIN = bin
COPY = copybooks
OUT = output

COBFLAGS = -I $(COPY)

ifeq ($(OS),Windows_NT)
    MKDIR = if not exist $(BIN) mkdir $(BIN) && if not exist $(OUT) mkdir $(OUT)
    RM = rmdir /S /Q
	CLEAR = cls
    EXE = .exe
else
    MKDIR = mkdir -p $(BIN) $(OUT)
    RM = rm -rf
	CLEAR = clear
    EXE =
endif

.PHONY: compile BHCPH000 BHCPH001 clean

compile: clean
	$(MKDIR)
	$(COBC) -x $(COBFLAGS) -o $(BIN)/BHCPH000$(EXE) $(SRC)/BHCPH000.cbl
	$(COBC) -c $(COBFLAGS) -o $(BIN)/BHCSH001.o $(SRC)/BHCSH001.cbl
	$(COBC) -x $(COBFLAGS) -o $(BIN)/BHCPH001$(EXE) $(SRC)/BHCPH001.cbl $(BIN)/BHCSH001.o

BHCPH000: compile
	$(CLEAR)
	cd $(OUT) && ../$(BIN)/BHCPH000$(EXE)

BHCPH001: BHCPH000
	$(CLEAR)
	cd $(OUT) && ../$(BIN)/BHCPH001$(EXE)

run: compile
	$(CLEAR)
	cd $(OUT) && ../$(BIN)/BHCPH000$(EXE)
	cd $(OUT) && ../$(BIN)/BHCPH001$(EXE)

clean:
	-$(RM) $(BIN)
	-$(RM) $(OUT)