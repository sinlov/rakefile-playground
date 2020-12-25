## run as cli

### full out

```bash
# Display the tasks (matching optional PATTERN) with descriptions
$ rake -T
rake clean             # Remove any temporary products
rake cleanOut          # clean out folder: outputs
rake clobber           # Remove any generated files
rake groupOne:genAll   # do this group (groupOne) all gen task
rake groupOne:one:gen  # group one, pandoc to folder outputs/one/one
rake groupOne:two:gen  # group one, pandoc to folder outputs/one/two
rake groupTwo:gen      # group two, pandoc to folder outputs/two

# Display the tasks and dependencies
$ rake -P
rake clean
rake cleanOut
rake clobber
    clean
rake groupOne:genAll
    one:gen
    two:gen
rake groupOne:one:gen
rake groupOne:two:gen
rake groupTwo:gen
```

### each task

```bash
$ rake groupOne:one:gen
task [ groupOne:one:gen ] run
mkdir -p outputs/one/one
pandoc -o outputs/one/one/ch1.html sources/ch1.md
mkdir -p outputs/one/one
pandoc -o outputs/one/one/ch2.html sources/ch2.md
mkdir -p outputs/one/one
pandoc -o outputs/one/one/ch3.html sources/ch3.md
mkdir -p outputs/one/one
pandoc -o outputs/one/one/ch5.html sources/ch5.md
mkdir -p outputs/one/one/subdir
pandoc -o outputs/one/one/subdir/appendix.html sources/subdir/appendix.md
mkdir -p outputs/one/one
pandoc -o outputs/one/one/temp.html sources/temp.md
mkdir -p outputs/one/one
pandoc -o outputs/one/one/ch4.html sources/ch4.markdown
```

```bash
$ rake groupOne:two:gen
mkdir -p outputs/one/two
pandoc -o outputs/one/two/ch1.html sources/ch1.md
mkdir -p outputs/one/two
pandoc -o outputs/one/two/ch2.html sources/ch2.md
mkdir -p outputs/one/two
pandoc -o outputs/one/two/ch3.html sources/ch3.md
mkdir -p outputs/one/two
pandoc -o outputs/one/two/ch5.html sources/ch5.md
mkdir -p outputs/one/two/subdir
pandoc -o outputs/one/two/subdir/appendix.html sources/subdir/appendix.md
mkdir -p outputs/one/two
pandoc -o outputs/one/two/temp.html sources/temp.md
mkdir -p outputs/one/two
pandoc -o outputs/one/two/ch4.html sources/ch4.markdown
```

```bash
$ rake groupTwo:gen
task [ groupTwo:gen ] run
mkdir -p outputs/two
pandoc -o outputs/two/ch1.html sources/ch1.md
mkdir -p outputs/two
pandoc -o outputs/two/ch2.html sources/ch2.md
mkdir -p outputs/two
pandoc -o outputs/two/ch3.html sources/ch3.md
mkdir -p outputs/two
pandoc -o outputs/two/ch5.html sources/ch5.md
mkdir -p outputs/two/subdir
pandoc -o outputs/two/subdir/appendix.html sources/subdir/appendix.md
mkdir -p outputs/two
pandoc -o outputs/two/temp.html sources/temp.md
mkdir -p outputs/two
pandoc -o outputs/two/ch4.html sources/ch4.markdown
```

```bash
$ rake cleanOut
rm -rf outputs
```