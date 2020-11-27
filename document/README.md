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