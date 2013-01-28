CC = gcc
CC += -c
CPP = g++
CPP += -c 
LD = g++
RM = rm
RM += -rf


SRC_DIR=../../source/ex-03
BUILD_DIR=../../build
CPP_EX_03 = $(BUILD_DIR)/ex-03
GTEST_OBJS = $(BUILD_DIR)/gtest-all.o $(BUILD_DIR)/gtest-main.o
CPP_LIBS = -lpthread 


OBJS_CPP_EX_03 = $(BUILD_DIR)/ex-03.o 

$(BUILD_DIR)/ex-03.o: $(SRC_DIR)/ex-03.cpp
	@echo "Compiling "$@
	@echo "    CPP       "$<
	$(CPP) -I../.. -O0 -g3 -Wall -o $@ $< -DTESTING
	@echo 'Finished building: $<'
	@echo ' '

all: pre_compile $(CPP_EX_03)

pre_compile: $(SRC_DIR)/ex-03.w
	@echo "CWEB weaving: "$<
	@echo ' '
	ctangle $<
	cweave  $<
	pdftex ex-03.tex
	cp ex-03.c ex-03.cpp
	@echo 'Finished weaving: $<'
	@echo ' '


$(CPP_EX_03) : $(OBJS_CPP_EX_03) 
	@echo "Linking "$@
	@echo "    LD        -o "$(CPP_EX_03)"        "$(OBJS_CPP_EX_03)
	$(LD) -o $(CPP_EX_03) $(OBJS_CPP_EX_03) $(GTEST_OBJS) $(CPP_LIBS)


clean:
	$(RM) $(OBJS_CPP_EX_03) $(FILES_TEMP)

FILES_TEMP = $(SRC_DIR)/ex-03.cpp  \
              $(SRC_DIR)/ex-03.pdf  \
              $(SRC_DIR)/ex-03.tex  \
              $(SRC_DIR)/ex-03.log \
              $(SRC_DIR)/ex-03.idx  \
              $(SRC_DIR)/ex-03.scn  \
              $(SRC_DIR)/ex-03.toc  \
              $(SRC_DIR)/ex-03.c


