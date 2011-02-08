Factory.define :exhibition do |f|
  f.sequence(:name) {|i| "Test Exhibition #{i}"}
end

