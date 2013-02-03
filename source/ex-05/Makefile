CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/ex-05
BUILD_DIR=../../build
CPP_EX_05 = $(BUILD_DIR)/ex-05
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_EX_05 = $(BUILD_DIR)/ex-05.o 

$(BUILD_DIR)/ex-05.o: $(SRC_DIR)/ex-05.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_EX_05)

pre_compile: $(SRC_DIR)/ex-05.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex ex-05.tex
	cp ex-05.c ex-05.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_EX_05) : $(OBJS_CPP_EX_05) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_EX_05)"        "$(OBJS_CPP_EX_05)
	$(LD) -o $(CPP_EX_05) $(OBJS_CPP_EX_05) $(GTEST_OBJS) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CPP_EX_05) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/ex-05.cpp  \
              $(SRC_DIR)/ex-05.pdf  \
              $(SRC_DIR)/ex-05.tex  \
              $(SRC_DIR)/ex-05.log \
              $(SRC_DIR)/ex-05.idx  \
              $(SRC_DIR)/ex-05.scn  \
              $(SRC_DIR)/ex-05.toc  \
              $(SRC_DIR)/ex-05.c


