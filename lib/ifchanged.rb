# -*- coding: utf-8 -*-

require 'optparse'
require 'rubygems'
require 'ifchanged/version'
require 'ifchanged/file_info'
require 'ifchanged/observer'

Thread.abort_on_exception = true

module IfChanged
  class << self
    def run(argv)
      files = []
      script = 
      interval = 1
      help = ''

      OptionParser.new do |opt|
        opt.version = VERSION
        opt.banner = "Usage: #{opt.program_name} --do=script files"
        opt.on('-d', '--do=script', 'Script') {|v| script = v}
        opt.on('-i', '--interval=interval', 'Interval of check files', Integer) {|v| interval = v}
        opt.permute!(argv)
        files = argv
        help = opt.help
      end

      if files.empty?
        puts help
        exit!
      end

      Observer.add_hook do |files|
        puts "modified: #{files.join(', ')}"
        run_script = eval("\"#{script}\"")
        puts "run: #{run_script}"
        system *run_script.split(/\s+/)
      end

      Observer.run(:files => files, :interval => interval)
    end
  end
end
