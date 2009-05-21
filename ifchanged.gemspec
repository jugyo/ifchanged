Gem::Specification.new do |s|
  s.name = 'ifchanged'
  s.version = '0.1.1'
  s.summary = "If files changed, do something."
  s.description = "Command line tool that run script when files are changed."
  s.files = %w( lib/ifchanged/file_info.rb lib/ifchanged/observer.rb lib/ifchanged/version.rb lib/ifchanged.rb
                
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
