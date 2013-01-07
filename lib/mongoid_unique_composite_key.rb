module Mongoid::UniqueCompositeKey
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validates_unique_key
      before_validation { |document| document.send(:check_for_collision) }
    end
  end

  module InstanceMethods
    private
    def check_for_collision
      key_field = primary_key.first
      if changed_attributes.include?(key_field.to_s)
        canonical_id = send(key_field).identify
        records = self.class.all(:conditions => {:id => canonical_id})
        if records.count > 1 ||
           (records.count == 1 && records.first != self)
          message = "#{key_field.to_s.capitalize} too similar to that of an existing #{self.class.to_s.underscore.humanize.downcase}"
          errors.add(key_field, message)
        end
      end
    end
  end
end
