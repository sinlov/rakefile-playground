# run

```bash
$ tree
.
├── Rakefile
├── ch1.md
├── ch2.md
├── ch3.md
├── ch4.markdown
├── scratch
│   └── test.md
├── subdir
│   └── appendix.md
├── temp.md
└── ~ch1.md
```

```bash
$ rake -P
files # => [ch1.md ch2.md ch3.md temp.md ~ch1.md]
files # => [ch1.md ch2.md ch3.md temp.md ~ch1.md ch4.markdown]
files # => [ch1.md ch2.md ch3.md scratch/test.md subdir/appendix.md temp.md ~ch1.md ch4.markdown]
files exclude # => [ch1.md ch2.md ch3.md scratch/test.md subdir/appendix.md temp.md ch4.markdown]
files exclude scratch # => [ch1.md ch2.md ch3.md subdir/appendix.md temp.md ch4.markdown]
files exclude scratch and empty # => [ch1.md ch2.md ch3.md subdir/appendix.md temp.md ch4.markdown]
files exclude sort # => [ch1.md ch2.md ch3.md subdir/appendix.md temp.md ch4.markdown]
files.ext(".html") # => [ch1.html ch2.html ch3.html subdir/appendix.html temp.html ch4.html]
rake default
    html
rake html
    ch1.html
    ch2.html
    ch3.html
    subdir/appendix.html
    temp.html
    ch4.html
```