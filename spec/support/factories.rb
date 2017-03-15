FactoryGirl.define do
  factory :user, class: User do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password "password"
    password_confirmation "password"
    after :create do |t|
      t.update_column(:avatar, "#{Rails.root}/spec/support/images/photo.png")
    end
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
    state 'Pennsylvania'
    zip '19123'
    after :create do |t|
      t.update_column(:image, "#{Rails.root}/spec/support/images/popcorn.jpg")
    end
  end
end
