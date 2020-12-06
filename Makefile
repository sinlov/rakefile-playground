.PHONY: test check clean build dist all

# each tag change this
ENV_DIST_VERSION := 1.0.0

# change project name
ENV_PROJECT_NAME=rakefile-playground

ENV_ROOT ?= $(shell pwd)

utils:
	npm install -g commitizen cz-conventional-changelog conventional-changelog-cli
	ruby -v
	bundle -v
	bundle config list

versionHelp:
	@git fetch --tags
	@echo "project base info"
	@echo " project name         : ${ENV_PROJECT_NAME}"
	@echo " module folder path   : ${ENV_MODULE_FOLDER}"
	@echo ""
	@echo "=> please check to change version, now is [ ${ENV_DIST_VERSION} ]"
	@echo "-> check at: ${ENV_ROOT_MAKE_FILE}:4"
	@echo " $(shell head -n 4 ${ENV_ROOT_MAKE_FILE} | tail -n 1)"
	@echo "-> check at: ${ENV_ROOT_MANIFEST}:3"
	@echo " $(shell head -n 3 ${ENV_ROOT_MANIFEST} | tail -n 1)"

tagBefore: versionHelp
	@cd ${ENV_MODULE_FOLDER} && conventional-changelog -i ${ENV_CHANGELOG} -s --skip-unstable
	@echo ""
	@echo "=> new CHANGELOG.md at: ${ENV_CHANGELOG}"
	@echo "place check all file, then can add tag like this!"
	@echo "$$ git tag -a '${ENV_DIST_VERSION}' -m 'message for this tag'"

cleanGemCache:
	@if [ -f ${ENV_GEM_LOCK_FILE} ]; \
	then rm -f ${ENV_GEM_LOCK_FILE} && echo "~> cleaned ${ENV_GEM_LOCK_FILE}"; \
	else echo "~> has cleaned ${ENV_GEM_LOCK_FILE}"; \
	fi

cleanAll: cleanGemCache
	@echo "=> clean all finish"

installGlobal:
	gem install --user-install bundler

install:
	bundler install

installAll: utils installGlobal install
	@echo "=> install all finish"

clean1Base:
	cd ${ENV_ROOT}/1-base && rm *.html

run1Base:
	cd ${ENV_ROOT}/1-base && bundler exec rake

clean2FileList:
	cd ${ENV_ROOT}/2-file-lists && find . -name "*.html" | xargs rm -f

run2FileList:
	cd ${ENV_ROOT}/2-file-lists && bundler exec rake

clean3Rules:
	cd ${ENV_ROOT}/3-rules && find . -name "*.html" | xargs rm -f

run3Rules:
	cd ${ENV_ROOT}/3-rules && bundler exec rake

run4PathMap:
	cd ${ENV_ROOT}/4-path-map && bundler exec rake

run5FileOperations:
	cd ${ENV_ROOT}/5-file-operations && bundler exec rake

clean5FileOperations:
	cd ${ENV_ROOT}/5-file-operations && find . -name "*.html" | xargs rm -f
	@if [ -d ${ENV_ROOT}/5-file-operations/outputs ]; \
	then rm -rf ${ENV_ROOT}/5-file-operations/outputs && echo "~> cleaned ${ENV_ROOT}/5-file-operations/outputs"; \
	else echo "~> has cleaned ${ENV_ROOT}/5-file-operations/outputs"; \
	fi

run6CleanAndClobber:
	cd ${ENV_ROOT}/6-Clean-and-Clobber && bundler exec rake

clean6CleanAndClobber:
	cd ${ENV_ROOT}/6-Clean-and-Clobber && bundler exec rake -T
	cd ${ENV_ROOT}/6-Clean-and-Clobber && bundler exec rake clobber clean

help:
	@echo "ruby module makefile template"
	@echo ""
	@echo " tips: can install node and install utils as"
	@echo "$$ make utils               ~> install utils"
	@echo "  1. then write git commit log, can replace [ git commit -m ] to [ git cz ]"
	@echo "  2. generate CHANGELOG.md doc: https://github.com/commitizen/cz-cli#conventional-commit-messages-as-a-global-utility"
	@echo ""
	@echo "  then you can generate CHANGELOG.md as"
	@echo "$$ make versionHelp         ~> print version when make tageBefore will print again"
	@echo "$$ make tagBefore           ~> generate CHANGELOG.md and copy to module folder"
	@echo ""
	@echo " project name         : ${ENV_PROJECT_NAME}"
	@echo ""
	@echo "Warning: must install node and install module as"
	@echo "$$ make installGlobal       ~> install must tools at global"
	@echo "$$ make install             ~> install project"
	@echo "$$ make installAll          ~> install all include global utils"
	@echo " run demo as"
	@echo "$$ make run1Base            ~> run ${ENV_ROOT}/1-base"
	@echo "$$ make run2FileList        ~> run ${ENV_ROOT}/2-file-lists"
	@echo "$$ make run3Rules           ~> run ${ENV_ROOT}/3-rules"
	@echo "$$ make run4PathMap         ~> run ${ENV_ROOT}/4-path-map"
