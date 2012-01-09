# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bbase::Application.initialize!

# I'm not using ruby-debug, so I alias debugger to pry
unless Rails.env == "production"
  class Object
    def debugger
      binding.pry # Just type "next" and press enter to get to your debugging session as you expected :)
    end
  end
end
