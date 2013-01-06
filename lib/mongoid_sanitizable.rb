module Mongoid::Sanitizable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def sanitizes(field)
      before_save do |document|
        if document.changed_attributes.include?(field.to_s)
          sanitized = Sanitize.clean(document.send(field),
                                     Sanitize::Config::RELAXED)
          document.set(field, sanitized)
        end
      end
    end
  end
end
