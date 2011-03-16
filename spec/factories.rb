#By using the symbol ':user' we get Factory Girl to simulate the User model.
Factory.define :user, :class => User do |user|
  user.sequence(:username) {|n| "Testor#{n}"}
  user.sequence(:email) {|n| "test#{n}@testor.com"}
  user.password "foobar"
  user.password_confirmation "foobar"
  user.sequence(:persistence_token) {|n| "#{Authlogic::Random.hex_token}"}
end

Factory.define :invalid_user, :class => User do |user|
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :username do |n|
  "person-#{n}"
end
