require 'rake'
require 'pathname'
require 'rake/clean'

Dir.chdir Pathname.getwd()

SOURCE_FILES = Rake::FileList.new("sources/**/*.md", "sources/**/*.markdown") do |fl|
  fl.exclude("**/~*")
  fl.exclude(/^sources\/scratch\//)
  fl.exclude do |f|
    `git ls-files #{f}`.empty?
  end
end

task :default => :gen_html
# puts "SOURCE_FILES => #{SOURCE_FILES}"
GEN_FILES = SOURCE_FILES.pathmap("%{^sources/,outputs/}X.html")
# task :html_path => SOURCE_FILES.pathmap("%{^sources/,outputs/}X.html")

OUT_FILES = Rake::FileList.new("outputs/**/**") do |fl|
  fl.exclude("~*")
end
OUT_HTML = OUT_FILES.ext(".html")
CLEAN.include(OUT_HTML)
CLEAN.include(OUT_HTML)

task :gen_html => GEN_FILES
# multitask :gen_html => GEN_FILES

directory "outputs"

rule ".html" => [->(f){source_for_html(f)}, "outputs"] do |t|
  # puts "do => t.name.pathmap(\"%d\") #{t.name.pathmap("%d")}"
  mkdir_p t.name.pathmap("%d")
  sh "pandoc -o #{t.name} #{t.source}"
end

def source_for_html(html_file)
  SOURCE_FILES.detect{|f|
    f.ext('') == html_file.pathmap("%{^outputs/,sources/}X")
  }
end