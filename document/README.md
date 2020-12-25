# Rake 快速教程

<!-- TOC -->

- [Rake 快速教程](#rake-快速教程)
  - [什么是 Rakefile](#什么是-rakefile)
  - [Rake 常用命令](#rake-常用命令)
  - [常用 Rakefile 模板](#常用-rakefile-模板)
  - [Rakefile 的基础用法](#rakefile-的基础用法)
  - [File-list](#file-list)
  - [rules](#rules)
  - [PathMap](#pathmap)
  - [文件操作](#文件操作)
  - [清理构建](#清理构建)
  - [多核构建](#多核构建)
  - [构建依赖](#构建依赖)
  - [停止构建和问答式执行](#停止构建和问答式执行)

<!-- /TOC -->

## 什么是 Rakefile

- Rakefile就是使用Ruby语法的 Makefile, 对应make的工具就是 rake，对应仓库在 [https://github.com/ruby/rake](https://github.com/ruby/rake)
- Rakefile 在 ruby 构建时充当 task 制定，依赖，执行的媒介
- 很多框架，比如 [Ruby on Rails](https://github.com/rails/rails) 数据库的初始化, 内容初始化, 删除 ,测试 等等都是 Rakefile 在操作
- 默认情况下，`rake` 命令会执行当前目录下的 `Rakefile`

## Rake 常用命令

```bash
# 打印 Rakefile 所有的任务列表
$ rake -T
# 打印 Rakefile 所有的任务依赖关系
$ rake -P
# 打印调试信息 Rakefile
$ rake -t
```

## 常用 Rakefile 模板

```ruby
require 'rake'
require 'rake/clean'
require 'pathname'
Dir.chdir Pathname.getwd()

DIST_PATH=File.join(Pathname.getwd(), 'dist') # set dist path

desc "default task"
task :default => :html # set default task

source_files = Rake::FileList.new("**/*.md", "**/*.markdown") do |fl|
  fl.exclude("~*")
  fl.exclude(/^scratch\//)
  fl.exclude do |f|
    `git ls-files #{f}`.empty? # must git add file
  end
end

# puts "html in #{source_files.ext(".md")}"
desc "html task"
task :html => source_files.ext(".html")
# multitask :html => source_files.ext(".html") # do multitask

rule ".html" => ".md" do |t|
  out_folder=File.join(Pathname.getwd(), 'dist')
  if not File.directory?(DIST_PATH)
    mkdir_p DIST_PATH
  end
  sh "file #{t.source}"
  out_file=File.join(DIST_PATH, t.name)
  msg "do out: #{out_file} in: #{t.source}"
end

desc "clean out folder: outputs"
task :cleanOut do
  rm_rf DIST_PATH
end

out_files = Rake::FileList.new("**/*.html", "**/*.mhtml") do |fl|
  fl.exclude("~*")
  # fl.exclude(/^scratch\//)
  # fl.exclude do |f|
  #   `git ls-files #{f}`.empty?
  # end
end
# msg out_files.ext(".html")
CLEAN.include(out_files.ext(".html"))

def msg(text)
  puts " -> msg: #{text}"
end
```

## Rakefile 的基础用法

本质上，Rakefile 还是 ruby 脚本，那么肯定包含 ruby 语法，比如打印日志用 `puts`

Rakefile 在此基础上分几个基本的build规则
- 任务:  `task` 默认任务为 default，使用 task :[name] do end 来定义一个 name 的任务
- 任务描述：`desc` 对任务进行描述
- 命名空间: `namespace` 一般用于区分任务组
- 调用任务: `invoke` 调用任务

简单实例

```ruby
task default: %w[test]

task :test do
  ruby "test/unittest.rb"
end
```
表示为: 默认任务使用 `test` 任务覆盖，test 任务内容为运行 `ruby "test/unittest.rb"`


```ruby
task :default => :html
task :html => %W[ch1.html ch2.html ch3.html]

rule ".html" => ".md" do |t|
  sh "file #{t.source}"
  sh "pandoc -o #{t.name} #{t.source}"
end
```
表示为: 将对应 markdown 通过 pandoc 编译为 html 文件, 并且如果已经编译过文件则不在编译

## File-list

`Rake::FileList.new()` 用来获取目标文件列表

```ruby
source_files = Rake::FileList.new("**/*.md", "**/*.markdown") do |fl|
  fl.exclude("~*")
  fl.exclude(/^scratch\//)
  fl.exclude do |f|
    `git ls-files #{f}`.empty?
  end
end

task :html => source_files.ext(".html")

rule ".html" => ".md" do |t|
  sh "pandoc -o #{t.name} #{t.source}"
end

rule ".html" => ".markdown" do |t|
  sh "pandoc -o #{t.name} #{t.source}"
end

task :default => :html
```
- 扫描当前源码目录中 md 和 markdown 后缀的文件
- 排除 `~*` `/^scratch\//`, 以及 git ls-files 为空的文件
- 生成对应 html 文件

## rules

```ruby
require 'rake'
# open trace rules faster than cli --trace
# Rake.application.options.trace_rules = true

task :default => :html

source_files = Rake::FileList.new("**/*.md") do |fl|
  fl.exclude("~*")
  fl.exclude(/^scratch\//)
  fl.exclude do |f|
    `git ls-files #{f}`.empty?
  end
end

task :html => source_files.ext(".html")
rule ".html" => ".md" do |t|
  sh "pandoc -o #{t.name} #{t.source}"
end
```
- 扫描当前源码目录中 md 和 markdown 后缀的文件
- 排除 `~*` `/^scratch\//`, 以及 git ls-files 为空的文件
- 生成对应 html 文件
- 特别的，rule `要求生成的每个对应文件，和生成源得一一对应`

> 技巧： 设置 `Rake.application.options.trace_rules = true` 跟踪构建错误

## PathMap

Rake 修改了 Ruby 的 String 类以便让 FileList 支持特定相同方法
故，Path 有额外的占位符用来快速操作

- `%p` 完整路径
- `%f` 没有目录的文件名
- `%n` 没有目录和扩展名
- `%d` 只有目录
- `%x` 只有扩展名
- `%X` 排除扩展名

## 文件操作

Rakefile 带有常用的文件操作，非常方便操作当前文件

```ruby
# 加入目录
directory [folder]

# 根据 Filemap 父目录路径创建文件夹，常用来生成文件夹
mkdir_p t.name.pathmap("%d")

# 删除目录
rm_rf [folder]

# 执行命令
sh [cmd]
```

> 执行 rake 时使用 `-q` 参数来忽略 sh 执行日志

## 清理构建

Rake 提供默认文件清理任务 `rake clean` 此任务使用 `CLEAN.include` 来导入需要清理的文件列表

```ruby
# 必须引入
require 'rake/clean'

CLEAN.include(SOURCE_FILES.ext(".html"))
CLEAN.include("book.epub")
```

Rake 提供文件清理任务 `rake clobber`， 此任务只能导入文件列表到 `CLOBBER` 这个数组
`clobber` 任务的清理目标视为最终生产目标，而 clean 任务为情理构建中间产物

```ruby
# 必须引入
require 'rake/clean'

file "book.epub"

CLOBBER << "book.epub"

file "book.mobi"
CLOBBER << "book.mobi"
```

当然也可以粗暴的设置任务，删除构建文件夹

```ruby
task :cleanOutPuts do
  rm_rf "outputs"
end
```

## 多核构建

默认情况下，Rake 是单核构建的，如果想用到多核构建，把 `task` 换成 `multitask` 比如

```ruby
# task :gen_html => GEN_FILES
multitask :gen_html => GEN_FILES
```

如果不想改构建代码，也想用到多核效果，可以在执行指定CPU核数来开启 `-j [cpu]`

```bash
# single
$ rake
# multi
$ rake -j 4
```

## 构建依赖

针对不同任务，可以做不同的依赖，最常用 namespace 来分割不同的任务

```ruby
namespace :group do
  namespace :Innergroup do
    task :gen do
    end
  end
  task :all => ["Innergroup:gen"]
end
```

通过简单的 `=>` 来指定依赖关系

打印依赖关系为

```bash
$ rake -P
rake group:Innergroup:gen
rake group:all
    Innergroup:gen
```

这样就可以减少重复任务编写，提高效率

> 注意， 使用了 namespace 分配的任务，那么对 CLOBBER 清理来说，直接作用域就会失效，那么得根据实际情况修改清理任务

## 停止构建和问答式执行

出现可预测的异常，需要停止构建的使用关键字 `abort`, 直接让当前构建退出，并返回错误

```ruby
abort('error message')
```

问答式构建则复杂一点，需要函数 ask

```ruby
def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end
```

下面这个例子就是每当输出文件存在时，交互式问是否输入 n 来 打断构建

```ruby
GEN_FILES = Rake::FileList.new()
GEN_FILES.each do |t|
  if File::exists?(t.pathmap("%p"))
    abort("rake aborted! #{t.pathmap("%p")} not overwrite") if ask("#{t.pathmap("%p")} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end
  sh "pandoc -o #{t.pathmap("%p")} #{RES_FILES[each_code]}"
end
```
