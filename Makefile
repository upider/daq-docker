all: download builder runner

help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

ARCHIVE_FILES := $(ARCHIVE_DIR)/argtable.tar.gz $(ARCHIVE_DIR)/boost.tar.gz $(ARCHIVE_DIR)/googletest.tar.gz $(ARCHIVE_DIR)/hiredis.tar.gz \
				$(ARCHIVE_DIR)/libevent.tar.gz $(ARCHIVE_DIR)/librdkafka.tar.gz $(ARCHIVE_DIR)/protobuf-all.tar.gz $(ARCHIVE_DIR)/googlere2.tar.gz \
				$(ARCHIVE_DIR)/root.tar.gz $(ARCHIVE_DIR)/soci.tar.gz $(ARCHIVE_DIR)/spdlog.tar.gz $(ARCHIVE_DIR)/libzmq.tar.gz \
				$(ARCHIVE_DIR)/jsoncpp.tar.gz $(ARCHIVE_DIR)/postgresql.tar.gz $(ARCHIVE_DIR)/xerces-c.tar.gz

ARCHIVE_DIR := ./archives

download: ## Download dependences
	@if [ -e $(ARCHIVE_DIR)/argtable.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/argtable.tar.gz exist; \
	else \
		wget https://github.com/argtable/argtable3/releases/download/v3.2.1.52f24e5/argtable-v3.2.1.52f24e5.tar.gz -O $(ARCHIVE_DIR)/argtable.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/boost.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/boost.tar.gz exist; \
	else \
		 wget https://boostorg.jfrog.io/artifactory/main/release/1.66.0/source/boost_1_66_0.tar.gz -O $(ARCHIVE_DIR)/boost.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/googletest.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/googletest.tar.gz exist; \
	else \
		wget https://github.com/google/googletest/archive/refs/tags/release-1.8.0.tar.gz -O $(ARCHIVE_DIR)/googletest.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/hiredis.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/hiredis.tar.gz exist; \
	else \
		wget https://github.com/redis/hiredis/archive/refs/tags/v0.13.3.tar.gz -O $(ARCHIVE_DIR)/hiredis.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/libevent.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/libevent.tar.gz exist; \
	else \
		wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz -O $(ARCHIVE_DIR)/libevent.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/librdkafka.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/ibrdkafka.tar.gz exist; \
	else \
		wget https://github.com/edenhill/librdkafka/archive/refs/tags/v1.5.0.tar.gz -O $(ARCHIVE_DIR)/librdkafka.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/protobuf-all.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/protobuf-all.tar.gz exist; \
	else \
		wget https://github.com/protocolbuffers/protobuf/releases/download/v3.5.1/protobuf-all-3.5.1.tar.gz -O $(ARCHIVE_DIR)/protobuf-all.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/googlere2.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/googlere2.tar.gz exist; \
	else \
		wget https://github.com/google/re2/archive/refs/tags/2021-06-01.tar.gz -O $(ARCHIVE_DIR)/googlere2.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/root.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/root.tar.gz exist; \
	else \
		wget https://root.cern/download/root_v6.16.00.Linux-centos7-x86_64-gcc4.8.tar.gz -O $(ARCHIVE_DIR)/root.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/soci.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/soci.tar.gz exist; \
	else \
		wget https://github.com/SOCI/soci/archive/refs/tags/3.2.3.tar.gz -O $(ARCHIVE_DIR)/soci.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/spdlog.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/spdlog.tar.gz exist; \
	else \
		wget https://github.com/gabime/spdlog/archive/refs/tags/v1.8.5.tar.gz -O $(ARCHIVE_DIR)/spdlog.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/libzmq.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/libzmq.tar.gz exist; \
	else \
		wget https://github.com/zeromq/libzmq/releases/download/v4.2.3/zeromq-4.2.3.tar.gz -O $(ARCHIVE_DIR)/libzmq.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/jsoncpp.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/jsoncpp.tar.gz exist; \
	else \
		wget https://github.com/open-source-parsers/jsoncpp/archive/refs/tags/1.8.4.tar.gz -O $(ARCHIVE_DIR)/jsoncpp.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/postgresql.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/postgresql.tar.gz exist; \
	else \
		wget https://ftp.postgresql.org/pub/source/v12.7/postgresql-12.7.tar.gz -O $(ARCHIVE_DIR)/postgresql.tar.gz; \
	fi;

	@if [ -e $(ARCHIVE_DIR)/xerces-c.tar.gz ];then \
		echo  $(ARCHIVE_DIR)/xerces.tar.gz exist; \
	else \
		wget https://github.com/apache/xerces-c/archive/refs/tags/v3.2.3.tar.gz -O $(ARCHIVE_DIR)/xerces-c.tar.gz; \
	fi;

builder: ## Build docker image daq-builder
	docker build -t daq-builder:0.0.1 -f Dockerfile.builder .
	
runner: ## Builder docker image daq-runner
	docker build -t daq-runner:0.0.1 -f Dockerfile.runner .