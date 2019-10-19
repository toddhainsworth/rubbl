module Rubbl
  class DataObject
    def initialize(data = {})
      @data = data
    end

    ##
    # Allow for Foo.bar to return the :bar attribute
    def method_missing(m, *args, &block)
      return @data[m] if @data.key? m
      super
    end
  end
end
