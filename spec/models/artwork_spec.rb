require 'spec_helper'

describe Artwork do

  it "sanitizes the note field" do
    artwork = Factory.create(:artwork, :note => '<script type="text/javascript">alert("stwdg");</script>')
    artwork.note.should == "alert(\"stwdg\");"
  end
end
