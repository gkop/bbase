FactoryGirl.define do
  factory :resource do
    sequence(:title) {|i| "Test Resource #{i}"}
  end

  factory :writing, :parent => :resource do
    tags 'writing'
  end
end
