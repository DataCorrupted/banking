all: archive

FILES = addPath.m main.m
FOLDERS = ui challenge common doc entity entity-system test ticket sample

archive: all
	tar -zcvf banking.tar.gz $(FILES) $(FOLDERS) README.md