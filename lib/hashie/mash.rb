module Hashie

  class Mash
    attr_accessor :data

    def initialize
      @data = Hash.new
    end
    def method_missing(name, *args, &block)
      return !data[name.to_s.delete('?').to_sym].nil? if name.to_s.end_with? '?'
      if name.to_s.end_with? '='
        return data[name.to_s.delete('=').to_sym] = args[0]
      end
      data[name]
    end

  end
end