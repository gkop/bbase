require 'spec_helper'

describe Gallery do

  it "sanitizes the note field" do
    gallery = FactoryGirl.create(:gallery, :note => '<script type="text/javascript">alert("injected");</script>')
    gallery.note.should == "alert(\"injected\");"
  end
end
