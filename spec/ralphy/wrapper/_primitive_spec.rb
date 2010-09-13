require File.expand_path %(#{File.dirname(__FILE__)}/../../spec_helper)


describe "Ralphy::Primitive" do
  before do
    ::Ralphy::Klass = Class.new(::Ralphy::Primitive)
  end
  it "inherits from Nokogiri::XML::Element" do
    ::Ralphy::Klass.superclass.superclass.should == ::Ralphy::XMLElement
  end

  describe '.new' do
    it "is possible to accept no arguments" do
      lambda {::Ralphy::Klass.new}.should_not raise_error
    end
    it "has its arguments passed to attributes" do
      @klass = ::Ralphy::Klass.new(:x => 10, :y => 2, :style => 'stroke-width:2;')
      @klass[:x].should == "10"
      @klass[:y].should == "2"
      @klass[:style].should == 'stroke-width:2;'
    end
  end
  
  describe "options" do
    describe ".tag" do
      it "can define a tag" do
        ::Ralphy::Klass.send(:tag, 'tag')
        ::Ralphy::Klass.send(:tag).should == 'tag'
      end
      it "defaults to the downcased class name" do
        ::Ralphy::Klass.send(:tag).should == 'klass'
      end
    end

    describe ".document" do
      it "can set config" do
        ::Ralphy::Klass.send(:document, (doc = ::Nokogiri.XML '<svg></svg>'))
        ::Ralphy::Klass.send(:document).should == doc
      end
      it "has a default document" do
        ::Ralphy::Klass.send(:document).to_xml.should == %(<?xml version="1.0"?>\n)
      end
    end

    describe "attributes fonctions" do
      before do
        ::Ralphy::Klass.send(:attributes, :x => 0, :y => '0')
        ::Ralphy::Klass.send(:requires, :width, :height)
        @klass = ::Ralphy::Klass.new
      end

      describe ".arguments" do
        it "adds its arguments to the default set of arguments" do
          ::Ralphy::Klass.new['y'].should == '0'
          ::Ralphy::Klass.new[:x].should == '0'
        end

        it "allows attributes to be defined" do
          proc {@klass[:width] = 'test'}.should_not raise_error
          @klass[:width].should == 'test'
        end
        it "allows attributes to be defined when created" do
          proc {@klass = ::Ralphy::Klass.new(:height => '4')}.should_not raise_error
          @klass[:height].should == '4'
        end
        it "stops rendering if not everything is here" do
          proc {@klass.to_svg}.should raise_error(ArgumentError,
                                                  "Undefined arguments: [:width, :height]")
        end
        it "allows rendering when the object is valid" do
          @klass[:width] = '2'
          @klass[:height]= '0.0000001'
          @klass.should be_valid
          proc {@klass.to_svg}.should_not raise_error
        end
      end

      describe ".requires" do
        it "allows attributes to be defined" do
          proc {@klass[:width] = 'test'}.should_not raise_error
          @klass[:width].should == 'test'
        end
        it "allows attributes to be created when created" do
          proc {@klass = ::Ralphy::Klass.new(:height => '4')}.should_not raise_error
          @klass[:height].should == '4'
        end
        it "stops rendering when there are not enough arguments" do
          proc {@klass[:cx] = 'cxx'}.should raise_error(ArgumentError)
          @klass[:cx].should be_nil
        end
        it "stops undefined attributes from being defined when created" do
          proc {@klass = ::Ralphy::Klass.new(:cy => 'cyy')}.should raise_error(ArgumentError)
          @klass[:cy].should be_nil
        end

      end
    end


  end


  after do
    ::Ralphy.send :remove_const, :Klass.to_s.to_sym
  end
end
