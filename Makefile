FUNC_1_DIR = ./Task_2
FUNC_2_DIR = ./Task_7

all:
	$(MAKE) -C $(FUNC_1_DIR)
	$(MAKE) -C $(FUNC_2_DIR)

.PHONY: clean
clean:
	$(MAKE) -C $(FUNC_1_DIR) clean
	$(MAKE) -C $(FUNC_2_DIR) clean
