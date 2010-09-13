require File.expand_path %(#{File.dirname(__FILE__)}/../../spec_helper)

describe "Ralphy::Abstract" do
  it "can take any name" do
    @abstract = Ralphy::Abstract.new('uniquename', :x => 40)
    @abstract.to_svg.should == '<uniquename x="40"/>'
  end
end
