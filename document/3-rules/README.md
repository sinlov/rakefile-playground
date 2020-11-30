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

- 日志报告 ch4.html 实际上是要构建输出的文件，但任务将其理解为必须要一个明确的输入 ch4.md， 但是这个文件夹下是一个 ch4.markdown

> 因为 Rake 修改了 Ruby 的 String 类以便让 FileList 支持特定相同方法，

定义一个函数

```ruby
def source_for_html(html_file)
  SOURCE_FILES.detect{|f| f.ext('') == html_file.ext('')}
end
```

这个函数目的是删除文件扩展名，然后通过 lambda 函数调用

```ruby
rule ".html" => ->(f){source_for_html(f)} do |t|
  sh "pandoc -o #{t.name} #{t.source}"
end
```

调用时，把目标文件的名称传递给作为前提条件提供的 lambda
通过这个 lambda 的返回值，检查其是否与现有文件匹配
并认为该规则是匹配的，并继续执行关联的代码，这样就支持了不同后缀文件，也可用通过 rule 构建