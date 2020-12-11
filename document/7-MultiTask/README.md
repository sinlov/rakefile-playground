## run as cli

### full out

```bash
	bundler exec rake -f single-Rakefile.rb clean && \
	echo "\n=> run: rake -f single-Rakefile.rb" && \
	time bundler exec rake -f single-Rakefile.rb && \
	bundler exec rake -f multi-Rakefile.rb clean && \
	echo "\n=> run: rake -f multi-Rakefile.rb" && \
	time bundler exec rake -f multi-Rakefile.rb && \
	bundler exec rake -f single-Rakefile.rb clean && \
	echo "\n=> run: rake -f single-Rakefile.rb -j 4" && \
	time bundler exec rake -f single-Rakefile.rb -j 4

=> run: rake -f single-Rakefile.rb
mkdir -p outputs
mkdir -p outputs
pandoc -o outputs/ch1.html sources/ch1.md
mkdir -p outputs
pandoc -o outputs/ch2.html sources/ch2.md
mkdir -p outputs
pandoc -o outputs/ch3.html sources/ch3.md
mkdir -p outputs
pandoc -o outputs/ch5.html sources/ch5.md
mkdir -p outputs/subdir
pandoc -o outputs/subdir/appendix.html sources/subdir/appendix.md
mkdir -p outputs
pandoc -o outputs/temp.html sources/temp.md
mkdir -p outputs
pandoc -o outputs/ch4.html sources/ch4.markdown

real	0m0.974s
user	0m0.614s
sys	0m0.201s

=> run: rake -f multi-Rakefile.rb
mkdir -p outputs
mkdir -p outputs
mkdir -p outputs/subdir
pandoc -o outputs/ch3.html sources/ch3.md
mkdir -p outputs
pandoc -o outputs/ch4.html sources/ch4.markdown
pandoc -o outputs/ch2.html sources/ch2.md
mkdir -p outputs
pandoc -o outputs/temp.html sources/temp.md
mkdir -p outputs
pandoc -o outputs/ch1.html sources/ch1.md
mkdir -p outputs
pandoc -o outputs/ch5.html sources/ch5.md
pandoc -o outputs/subdir/appendix.html sources/subdir/appendix.md

real	0m0.607s
user	0m0.620s
sys	0m0.212s

=> run: rake -f single-Rakefile.rb -j 4
mkdir -p outputs
pandoc -o outputs/ch1.html sources/ch1.md
mkdir -p outputs
pandoc -o outputs/ch2.html sources/ch2.md
mkdir -p outputs
pandoc -o outputs/ch3.html sources/ch3.md
mkdir -p outputs
pandoc -o outputs/ch5.html sources/ch5.md
mkdir -p outputs/subdir
pandoc -o outputs/subdir/appendix.html sources/subdir/appendix.md
mkdir -p outputs
pandoc -o outputs/temp.html sources/temp.md
mkdir -p outputs
pandoc -o outputs/ch4.html sources/ch4.markdown

real	0m1.017s
user	0m0.610s
sys	0m0.198s
```