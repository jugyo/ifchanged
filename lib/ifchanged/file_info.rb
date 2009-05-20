module IfChanged
  class FileInfo

    attr_reader :pathname, :changes

    def initialize(pathname, observe_targets = [:mtime])
      @changes = []
      @pathname = pathname
      @targets = {}
      @observe_targets = observe_targets
      update_status()
    end

    def check_modified
      old = @targets.dup
      update_status()
      @changes = []
      @targets.each do |k, v|
        @changes << k unless old[k] == v
      end
    end

    private

    def update_status
      return unless @pathname.exist?
      @observe_targets.each do |target|
        @targets[target] = @pathname.__send__(target)
      end
    end
  end
end

