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
        assert_raise_argument_error(key, @data[key])

        define_singleton_method(:"#{key}=") do |defined_value|
          assert_raise_argument_error(key, defined_value)
          @data[key] = defined_value || value[:default]
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
      assert_raise_argument_error(key, value)
      @data[key] = value || self.class.local_data[key][:default]
    end

    def has_default?(key)
      self.class.local_data[key].has_key?(:default)
    end

    def assert_raise_argument_error(key, value)
      raise ArgumentError, "ArgumentError: The property '#{key}' is required for this Dash." \
        if value.nil? && self.class.local_data[key][:required] && !has_default?(key)
    end
  end
end
