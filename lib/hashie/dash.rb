module Hashie
  class Dash
    class << self
      attr_reader :local_data

      def property(name, options = {})
        @local_data ||= {}
        @local_data[name] = options
      end
    end

    def initialize(hash = {})
      @data = {}
      self.class.local_data.each do |key, value|
        @data[key] = hash[key] || value[:default]
        raise ArgumentError if @data[key].nil? && value[:required]
        define_singleton_method(:"#{key}=") do |defined_value|
          raise ArgumentError if defined_value.nil? && self.class.local_data[key][:required]
          @data[key] = defined_value
        end

        define_singleton_method(key) do
          @data[key]
        end
      end
    end

    def [](key)
      raise NoMethodError if !@data.has_key?(key)
      @data[key]
    end

    def []=(key, value)
      raise ArgumentError if value.nil? && self.class.local_data[key][:required]
      @data[key] = value
    end
  end
end