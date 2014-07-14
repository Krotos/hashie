module Hashie

  class Mash

    def initialize
      @data = {}
    end

    def method_missing(name, *args, &block)
      case name[-1]
        when '?' then !@data[name[0..-2].to_sym].nil?
        when '_' then Mash.new
        when '=' then @data[name[0..-2].to_sym] = args[0]
        when '!' then @data[name[0..-2].to_sym] = Mash.new
        else @data[name]
      end
    end

    def key?(asked_key)
      @data.include? (asked_key.to_sym)
    end
  end
end