require 'spec_helper'

describe Resource do

  it "sanitizes the note field" do
    writing = FactoryGirl.create(:writing, :note => '<script type="text/javascript">alert("stwdg");</script>')
    writing.note.should == "alert(\"stwdg\");"
  end
end
