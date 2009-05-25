require 'pathname'
require 'readline'
require 'singleton'

module IfChanged
  class Observer
    include Singleton

    def self.add_hook(&block)
      instance.add_hook(&block)
    end

    def self.run(options = {})
      instance.run(options)
    end

    attr_accessor :files, :interval, :debug, :prompt

    def initialize
      @interval = 1
      @work = true
      @file_infos = {}
      @hooks = []
      @prompt = '> '
    end

    def run(options = {})
      options.each do |k, v|
        self.__send__("#{k.to_s}=".to_sym, v) if self.respond_to?(k)
      end

      puts "# initializing..."

      trap(:INT) do
        self.exit
      end

      files.each do |file|
        pathname = Pathname.new(file)
        @file_infos[pathname] = FileInfo.new(pathname)
      end

      puts '# Press Ctrl-C to exit.'

      @observe_thread = Thread.new do
        while @work
          begin
            puts 'checking files...' if debug
            check_modifies
          rescue => e
            handle_error(e)
          ensure
            sleep @interval
          end
        end
      end

      @observe_thread.join
    end

    def exit
      puts
      puts 'exiting...'
      @work = false
    end

    def add_hook(&block)
      @hooks << block
    end

    private

    def check_modifies
      @file_infos.values.each{|i| i.check_modified}
      modifies = @file_infos.values.select{|i| !i.changes.empty?}
      call_hooks(modifies.map{|i| i.pathname}) unless modifies.empty?
    end

    def call_hooks(pathnames = [])
      @hooks.each do |hook|
        begin
          hook.call(pathnames.map{|i| i.to_s})
        rescue => e
          handle_error(e)
        end
      end
    end

    def handle_error(e)
      if debug
        puts "Error: #{e}"
        puts e.backtrace.join("\n")
      end
    end
  end
end
