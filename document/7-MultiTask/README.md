## run as cli

### full out

        bundler exec rake -f single-Rakefile.rb clean && \
        time bundler exec rake -f single-Rakefile.rb && \
        bundler exec rake -f multi-Rakefile.rb clean && \
        time bundler exec rake -f multi-Rakefile.rb && \
        bundler exec rake -f single-Rakefile.rb clean
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

real    0m1.094s
user    0m0.689s
sys     0m0.302s
mkdir -p outputs
mkdir -p outputs
pandoc -o outputs/ch1.html sources/ch1.md
mkdir -p outputs
mkdir -p outputs
pandoc -o outputs/temp.html sources/temp.md
mkdir -p outputs
mkdir -p outputs/subdir
pandoc -o outputs/ch3.html sources/ch3.md
pandoc -o outputs/ch2.html sources/ch2.md
pandoc -o outputs/ch4.html sources/ch4.markdown
pandoc -o outputs/subdir/appendix.html sources/subdir/appendix.md

real    0m0.920s
user    0m0.829s
sys     0m0.361s