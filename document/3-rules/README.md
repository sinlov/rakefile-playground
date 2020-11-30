## run as cli

### 第一次运行

```ruby
require 'rake'

source_files = Rake::FileList.new("**/*.md", "**/*.markdown") do |fl|
  fl.exclude("~*")
  fl.exclude(/^scratch\//)
  fl.exclude do |f|
    `git ls-files #{f}`.empty?
  end
end

task :default => :html
task :html => source_files.ext(".html")

rule ".html" => ".md" do |t|
  sh "pandoc -o #{t.name} #{t.source}"
end
```

```bash
$ rake -P
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

```bash
$ rake
rake aborted!
Don't know how to build task 'ch4.html' (See the list of available tasks with `rake --tasks`)
Did you mean?  ch3.html
               ch2.html
               ch1.html

Tasks: TOP => default => html
(See full trace by running task with --trace)
```

- 日志报告 ch4.html 实际上是要构建输出的文件，但任务将其理解为一个 task