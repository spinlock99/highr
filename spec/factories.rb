#By using the symbol ':user' we get Factory Girl to simulate the User model.
Factory.define :user, :class => User do |user|
#  user.sequence(:username) {|n| "Testor#{n}"}
  user.sequence(:email) {|n| "test#{n}@testor.com"}
  user.password "foobar"
  user.password_confirmation "foobar"
#  user.sequence(:persistence_token) {|n| "#{Authlogic::Random.hex_token}"}
end

Factory.define :team, :class => Team do |team|
  team.sequence(:name) {|n| "team#{n}"} 
end

Factory.define :invalid_user, :class => User do |user|
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

#Factory.sequence :username do |n|
#  "person-#{n}"
#end

Factory.define :hartman_value_profile do |hvp|
  hvp.taken_at DateTime.now
  hvp.association :user
end

Factory.define :hvp_element do |hvp_element|
  hvp_element.axiological_norm 1
  hvp_element.given_value 1
  hvp_element.part_id "self"
  hvp_element.category_id "intrinsic"
  hvp_element.association :hartman_value_profile
end

Factory.define :micropost do |micropost|
  micropost.content "Lorem ipsum"
  micropost.association :user
end


