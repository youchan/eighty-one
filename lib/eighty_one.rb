require_relative "eighty_one/version"

module EightyOne
  class CantGetMovement < RuntimeError; end
  module Helper
    def assert(cond, message = "")
      unless cond
        e = RuntimeError.new "assert error: #{message}"
        e.set_backtrace(caller)
        raise e
      end
    end
  end
end

require_relative 'eighty_one/face'
require_relative 'eighty_one/piece'
require_relative 'eighty_one/board'
