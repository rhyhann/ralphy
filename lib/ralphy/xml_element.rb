module Ralphy
  # Slightly changes the behaviour of the object
  # (mainly uses symbols)
  class XMLElement < Nokogiri::XML::Element
    # Define an argument using that method
    def []=(key, value)
      raise ArgumentError unless authorized_attribute?(key)
      super(key.to_s, value.to_s)
    end

    # Get your argument using that method
    def [](key)
      super(key.to_s)
    end

    # Get an array of keys
    def keys
      super.map(&:to_sym)
    end
  end
end
