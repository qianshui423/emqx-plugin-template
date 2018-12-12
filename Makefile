PROJECT = emqx_persistence_mongo
PROJECT_DESCRIPTION = EMQ X Plugin Message Persistence Mongo
PROJECT_VERSION = 3.0
PROJECT_MOD = emqx_message_persistence_mongo_app

DEPS = mongodb pbkdf2
dep_mongodb = git https://github.com/comtihon/mongodb-erlang.git master
dep_pbkdf2 = git https://github.com/comtihon/erlang-pbkdf2 master

BUILD_DEPS = emqx cuttlefish
dep_emqx = git-emqx https://github.com/emqx/emqx emqx30
dep_cuttlefish = git-emqx https://github.com/emqx/cuttlefish v2.1.1

ERLC_OPTS += +debug_info

NO_AUTOPATCH = cuttlefish

COVER = true

define dep_fetch_git-emqx
	git clone -q --depth 1 -b $(call dep_commit,$(1)) -- $(call dep_repo,$(1)) $(DEPS_DIR)/$(call dep_name,$(1)) > /dev/null 2>&1; \
	cd $(DEPS_DIR)/$(call dep_name,$(1));
endef

include erlang.mk

app:: rebar.config

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emqx_persistence_mongo.conf -i priv/emqx_persistence_mongo.schema -d data
