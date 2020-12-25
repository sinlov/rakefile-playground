## ch5 md

## run as cli

### full out

```bash
$ rake
mkdir -p outputs
mkdir -p outputs
pandoc -o outputs/ch1.html sources/ch1.md
mkdir -p outputs
pandoc -o outputs/ch2.html sources/ch2.md
mkdir -p outputs
pandoc -o outputs/ch3.html sources/ch3.md
mkdir -p outputs/subdir
pandoc -o outputs/subdir/appendix.html sources/subdir/appendix.md
mkdir -p outputs
pandoc -o outputs/temp.html sources/temp.md
mkdir -p outputs
pandoc -o outputs/ch4.html sources/ch4.markdown

$ rake clean
rm -rf outputs

# will not show sh
$ rake -q
```