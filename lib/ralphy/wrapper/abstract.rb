module Ralphy
  class Abstract < Primitive
    def self.new(name, options = {})
      tag(name)
      super(options)
    end
  end
end
