require 'spec_helper'
require 'stringify_tags'

describe StringifyTags do

  it "is correct with a single tag" do
    StringifyTags.stringify(["pear"]).should == "Pears"
  end

  it "is correct with two tags" do
    StringifyTags.stringify(["peach", "plum"]).should == "Peaches and plums"
  end

  it "is correct with three tags" do
    StringifyTags.stringify(["pluot", "pineapple", "persimmon"]).should ==
      "Pluots, pineapples, and persimmons"
  end
end
