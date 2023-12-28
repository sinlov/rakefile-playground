## before run task


- calibre cli [ebook-convert](https://manual.calibre-ebook.com/generated/en/cli-index.html) 5.6.+
  - can install by `brew install calibre` and add binary at `$PATH`
- [kindlegen](https://www.amazon.com/gp/feature.html?docId=1000765211) 2.9
  - known issue [KindleGen is no longer available for download](https://github.com/asciidoctor/asciidoctor-epub3/issues/363)
  - can use [bin/KindleGen_Mac_x64_v2_9.zip](https://github.com/sinlov/rakefile-playground/main/bin/KindleGen_Mac_x64_v2_9.zip) to replace

## run as cli

### full out

```bash
$ rake -T
rake clean    # Remove any temporary products
rake clobber  # Remove any generated files
$ rake -P
rake book.epub
    book.html
rake book.html
    backmatter/appendix.html
    ch1.html
    ch2.html
    ch3.html
    temp.html
    ch4.html
rake book.mobi
    book.epub
rake clean
rake clobber
    clean
rake default
    book.epub
    book.mobi
rake html
    backmatter/appendix.html
    ch1.html
    ch2.html
    ch3.html
    temp.html
    ch4.html
```
- generate html

```bash
$ rake html
pandoc -o backmatter/appendix.html backmatter/appendix.md
pandoc -o ch1.html ch1.md
pandoc -o ch2.html ch2.md
pandoc -o ch3.html ch3.md
pandoc -o temp.html temp.md
pandoc -o ch4.html ch4.markdown
```

- generate book

```bash
$ rake default
...
```

- clean output

```bash
$ rake clobber clean
```

