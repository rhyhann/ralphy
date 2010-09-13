require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ralphy" do
  it "includes all its dependencies" do
    Dir[%(#{File.dirname(__FILE__)}/../lib/ralphy/**/*.rb)].each do |element|
      require(element.gsub('.rb','')).should be_false
    end
  end
  it "has a version" do
    Ralphy::VERSION.should be_kind_of Integer
  end
end
