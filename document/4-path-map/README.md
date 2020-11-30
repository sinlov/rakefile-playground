## run as cli

### 完整输出为

```bash
$ rake
SOURCE_FILES => ch1.md ch2.md ch3.md sources/ch1.md sources/ch2.md sources/ch3.md sources/subdir/appendix.md sources/temp.md sources/~ch1.md subdir/appendix.md temp.md ch4.markdown sources/ch4.markdown
SOURCE_FILES.ext('html') => ch1.html ch2.html ch3.html sources/ch1.html sources/ch2.html sources/ch3.html sources/subdir/appendix.html sources/temp.html sources/~ch1.html subdir/appendix.html temp.html ch4.html sources/ch4.html
SOURCE_FILES.pathmap("%p") => ch1.md ch2.md ch3.md sources/ch1.md sources/ch2.md sources/ch3.md sources/subdir/appendix.md sources/temp.md sources/~ch1.md subdir/appendix.md temp.md ch4.markdown sources/ch4.markdown
SOURCE_FILES.pathmap("%f") => ch1.md ch2.md ch3.md ch1.md ch2.md ch3.md appendix.md temp.md ~ch1.md appendix.md temp.md ch4.markdown ch4.markdown
SOURCE_FILES.pathmap("%n") => ch1 ch2 ch3 ch1 ch2 ch3 appendix temp ~ch1 appendix temp ch4 ch4
SOURCE_FILES.pathmap("%d") => . . . sources sources sources sources/subdir sources sources subdir . . sources
SOURCE_FILES.pathmap("%x") => .md .md .md .md .md .md .md .md .md .md .md .markdown .markdown
SOURCE_FILES.pathmap("%X") => ch1 ch2 ch3 sources/ch1 sources/ch2 sources/ch3 sources/subdir/appendix sources/temp sources/~ch1 subdir/appendix temp ch4 sources/ch4
command => ruby -Imylibs -Iyourlibs -Isharedlibs myscript.rb
load_paths.to_s => mylibs yourlibs sharedlibs
load_paths.to_a.to_s => ["mylibs", "yourlibs", "sharedlibs"]
SOURCE_FOLDER_FILES => sources/ch1.md sources/ch2.md sources/ch3.md sources/subdir/appendix.md sources/temp.md sources/~ch1.md sources/ch4.markdown
OUTPUT_FILES => outputs/ch1.html outputs/ch2.html outputs/ch3.html outputs/subdir/appendix.html outputs/temp.html outputs/~ch1.html outputs/ch4.html
f => outputs/subdir/appendix.html
cmd => mkdir -p outputs/subdir
=> task default
this is demo
```