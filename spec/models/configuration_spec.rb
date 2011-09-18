require 'spec_helper'

describe Configuration do

  it "sanitizes the biography content" do
    Configuration.set("biography_content", '<script type="text/javascript">alert("stwdg");</script>')
    Configuration.get("biography_content").should == "alert(\"stwdg\");"
  end
end

