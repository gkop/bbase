require 'spec_helper'

describe Resource do

  it "sanitizes the note field" do
    writing = FactoryGirl.create(:writing, :note => '<script type="text/javascript">alert("stwdg");</script>')
    writing.note.should == "alert(\"stwdg\");"
  end

  it "validates the uniqueness of the composite key" do
    FactoryGirl.create(:writing, :title => "Fresh beats")
    second = FactoryGirl.build(:response, :title => "FRESH   BEATS")
    lambda { second.save! }.should raise_error(Mongoid::Errors::Validations)
    second.errors[:title].should ==
      ["Title too similar to that of an existing resource"]
  end
end
