require 'spec_helper'

describe Artwork do

  it "sanitizes the note field" do
    artwork = FactoryGirl.create(:artwork, :note => '<script type="text/javascript">alert("stwdg");</script>')
    artwork.note.should == "alert(\"stwdg\");"
  end

  it "validates the uniqueness of the composite key" do
    FactoryGirl.create(:artwork, :title => "Blue Sky")
    second = FactoryGirl.build(:artwork, :title => "Blue-sky")
    lambda { second.save! }.should raise_error(Mongoid::Errors::Validations)
    second.errors[:title].should ==
      ["Title too similar to that of an existing artwork"]
  end
end
