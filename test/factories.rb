Factory.define :user do |user|
  user.name "Test Person"
  user.email "test@example.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person#{n}@example.com"
end

