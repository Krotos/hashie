module Hashie
  class Dash
    class << self
      attr_reader :local_data

      def property(*args)
        @local_data ||= {}
        if args[1].nil?
          @local_data[args[0]] = {required: false}
        else
          @local_data[args[0]] ||= args[1]
          @local_data[args[0]][:required] ||= false
        end
      end
    end

    def initialize(*args)
      @data = self.class.local_data
      @data.each do |_, value|
        value[:value] = value[:default] if !value[:default].nil?
      end
      raise ArgumentError if args.empty?
      @data.each do |key, value|
        if value[:value].nil? && value[:required] && !args[0].include?(key)
          raise ArgumentError
        end
        value[:value] = args[0][key] if !args[0][key].nil?
      end
    end

    def method_missing(name, *args)
      if name[-1] == '='
        if @data[name[0..-2].to_sym][:required] && args[0].nil?
          raise ArgumentError
        else
          @data[name[0..-2].to_sym][:value] = args[0]
        end
      else
        @data[name][:value]
      end
    end
  end
end