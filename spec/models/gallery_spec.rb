require 'spec_helper'

describe Exhibition do

  it "sanitizes the note field" do
    gallery = Factory.create(:exhibition, :note => '<script type="text/javascript">alert("injected");</script>')
    gallery.note.should == "alert(\"injected\");"
  end
end
