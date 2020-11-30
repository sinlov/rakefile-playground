[TOC]

# 什么是 Rakefile

- Rakefile就是使用Ruby语法的 Makefile, 对应make的工具就是 rake，对应仓库在 [https://github.com/ruby/rake](https://github.com/ruby/rake)
- Rakefile 在 ruby 构建时充当 task 制定，依赖，执行的媒介
- 很多框架，比如 [Ruby on Rails](https://github.com/rails/rails) 数据库的初始化, 内容初始化, 删除 ,测试 等等都是 Rakefile 在操作

# Rakefile 的语法

本质上，Rakefile 还是 ruby 脚本，那么肯定包含 ruby 语法
Rakefile 在此基础上分几个基本的build规则
- 任务:  task 默认任务为 default，使用 task :[name] do end 来定义一个 name 的任务
- 任务描述：desc 对任务进行描述
- 命名空间: namespace 一般用于区分任务组
- 调用任务: invoke 调用任务

## 简单实例

```ruby
task default: %w[test]

task :test do
  ruby "test/unittest.rb"
end
```
表示为 默认任务使用 test 覆盖，test 任务内容为运行 `ruby "test/unittest.rb"`


```ruby
task :default => :html
task :html => %W[ch1.html ch2.html ch3.html]

rule ".html" => ".md" do |t|
  sh "file #{t.source}"
  sh "pandoc -o #{t.name} #{t.source}"
end
```
将对应 markdown 通过 pandoc 编译为 html 文件, 并且如果已经编译过文件则不在编译

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