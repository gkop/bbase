require 'spec_helper'

describe Settings do

  it "sanitizes the biography content" do
    Settings.set("biography_content", '<script type="text/javascript">alert("stwdg");</script>')
    Settings.get("biography_content").should == "alert(\"stwdg\");"
  end
end

