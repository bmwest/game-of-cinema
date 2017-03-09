FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@exmple.com" }
    first_name 'John'
    last_name 'Smith'
    password "password"
    password_confirmation "password"
  end

  factory :admin do
    sequence(:email) { |n| "admin#{n}@exmple.com" }
    first_name 'Admin'
    last_name 'Superpowers'
    password "superpowers"
    password_confirmation "superpowers"
  end
end
