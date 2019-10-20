module Rubbl
  class DataObject
    def initialize(data = {})
      @data = data
    end

    ##
    # Allow for Foo.bar to return the :bar attribute
    def method_missing(m, *args, &block)
      return @data[m.to_s] if @data.key? m.to_s
      super
    end
  end
end
