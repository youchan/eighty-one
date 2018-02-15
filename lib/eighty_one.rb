require "eighty_one/version"

module EightyOne
  class CantGetMovement < RuntimeError; end
  module Helper
    def assert(*conds)
      unless conds.all?
        e = RuntimeError.new 'assert error'
        e.set_backtrace(caller)
        raise e
      end
    end
  end
end

require 'eighty_one/face'
require 'eighty_one/piece'
require 'eighty_one/board'
