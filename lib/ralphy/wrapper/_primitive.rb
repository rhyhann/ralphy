module Ralphy
  class Primitive < XMLElement

    def initialize(tag, document)
      [:attributes, :requires, :tag, :document].each do |variable|
        instance_variable_set :"@#{variable}",
                              self.class.send(variable)
      end
    end

    # Get the SVG version of the element/document
    def to_svg
      raise ArgumentError,
            "Undefined arguments: #{left_attributes.inspect}" \
            unless valid?
      to_xml
    end

    # Attributes left
    def left_attributes
      @requires - keys
    end
    
    def valid?
      left_attributes.empty?
    end

    private
    # Sees if the attribute is authorized
    def authorized_attribute?(key)
      return true if @requires.empty? && @attributes.empty?
      (@attributes.keys + @requires).include? key.to_sym
    end


    public
    def self.new(options = {})
      object = super(tag, document)
      options.merge(attributes).each do |key, value|
        object[key] = value
      end
      object
    end


    protected

    # Define your static attributes here
    def self.attributes(attrs = {})
      if  attrs.empty? && !(defined?(@attributes)) &&
          self.superclass.respond_to?(:attributes)
        superclass.attributes
      else
        @attributes ||= attrs
      end
    end

    def self.requires(*attrs)
      return superclass.requires if attrs.empty? && !(defined?(@requires)) &&
                                    superclass.respond_to?(:requires)
      @requires ||= attrs
    end

    # Defines the tag name
    def self.tag(tag = tag_name)
      @tag ||= tag
    end

    # The document where the element will be added
    # Use it to wrap the element
    def self.document(document = ::Nokogiri::XML::Document.new)
      @document ||= document
    end

    private
    def self.tag_name
      to_s.split('::').last.downcase
    end

  end
end
