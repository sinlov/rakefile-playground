## run as cli

### full out

```bash
$ rake -T
rake clean    # Remove any temporary products
rake clobber  # Remove any generated files
rake default  # default task to html
rake html     # use pandoc gen markdown to html at folder outputs
```
- first run

```bash
$ rake
mkdir -p outputs
pandoc -o outputs/ch1.html sources/ch1.md
pandoc -o outputs/ch2.html sources/ch2.md
pandoc -o outputs/ch3.html sources/ch3.md
```

- secound run

```bash
$ rake
outputs/ch1.html already exists. Do you want to overwrite? [y/n] y
pandoc -o outputs/ch1.html sources/ch1.md
outputs/ch2.html already exists. Do you want to overwrite? [y/n] n
rake aborted! outputs/ch2.html not overwrite
FAIL
```