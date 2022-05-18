CURRENT_DIR = $(shell pwd)
EXAMPLES_PATH = $(CURRENT_DIR)/examples/*
SUBDIRS := $(shell find $(EXAMPLES_PATH) -maxdepth 0 -type d)

.PHONY: all


tfinit:
	for folder in $(SUBDIRS) ; do \
			cd $$folder && terraform init ; \
	done

tfplan:
	for folder in $(SUBDIRS) ; do \
			cd $$folder && terraform plan ; \
	done

tfaplly:
	for folder in $(SUBDIRS) ; do \
			cd $$folder &&  terraform plan --out=plan.tmp && terraform apply plan.tmp ; \
	done

tfdestroy:
	for folder in $(SUBDIRS) ; do \
			cd $$folder && terraform destroy --auto-approve ; \
	done

tfclean:
	for folder in $(SUBDIRS) ; do \
			rm -rf $$folder/.terraform* ; \
	done

examplescreate: tfinit tfaplly

examplesclean: tfdestroy tfclean
