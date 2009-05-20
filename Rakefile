# -*- coding: utf-8 -*-
$:.unshift File.dirname(__FILE__) + '/lib/'
require 'ifchanged'
require 'spec/rake/spectask'

desc 'run all specs'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['-c']
end

desc 'Generate gemspec'
task :gemspec do |t|
  open('ifchanged.gemspec', "wb" ) do |file|
    file << <<-EOS
Gem::Specification.new do |s|
  s.name = 'ifchanged'
  s.version = '#{IfChanged::VERSION}'
  s.summary = "If files changed, do something."
  s.description = "Command line tool that run script when files are changed."
  s.files = %w( #{Dir['lib/**/*.rb'].join(' ')}
                #{Dir['spec/**/*.rb'].join(' ')}
                README.rdoc
                History.txt
                Rakefile )
  s.executables = ["ifchanged"]
  s.author = 'jugyo'
  s.email = 'jugyo.org@gmail.com'
  s.homepage = 'http://github.com/jugyo/ifchanged'
  s.rubyforge_project = 'ifchanged'
  s.has_rdoc = false
end
    EOS
  end
  puts "Generate gemspec"
end

desc 'Generate gem'
task :gem => :gemspec do |t|
  system 'gem', 'build', 'ifchanged.gemspec'
end
