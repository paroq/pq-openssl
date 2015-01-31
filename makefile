include $(PQ_FACTORY)/factory.mk

pq_part_name := openssl-1.0.2
pq_part_file := $(pq_part_name).tar.gz

pq_openssl_configuration_flags += --prefix=$(part_dir)
pq_openssl_configuration_flags += shared threads

build-stamp: stage-stamp
	$(MAKE) -j1 -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -j1 -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) INSTALL_PREFIX=$(stage_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./config $(pq_openssl_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
