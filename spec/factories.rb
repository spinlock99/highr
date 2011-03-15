#By using the symbol ':user' we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.username "spinlock"
  user.email "dixon@atomicbroadcast.net"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :username do |n|
  "person-#{n}"
end
