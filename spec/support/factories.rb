FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
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

  factory :theater do
    sequence(:name) { |n| "Cinema#{n}" }
    address '123 Street'
    city 'Philadelphia'
    state 'PA'
    zip '19123'
  end
end
