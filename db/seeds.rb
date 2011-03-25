# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
HvpMaster.delete_all

HvpMaster.create do |hvp|
  hvp.axiological_norm = 6
  hvp.phrase = "A good meal"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 9
  hvp.phrase = "A technical improvement"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 10
  hvp.phrase = "Nonsense"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 11
  hvp.phrase = "A fine"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 13
  hvp.phrase = "A rubbish heap"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 5
  hvp.phrase = "A devoted scientist"
  hvp.part_id = "world"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 17
  hvp.phrase = "Blow up an airliner in flight"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 16
  hvp.phrase = "Burn a witch at the stake"
  hvp.part_id = "world"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 12
  hvp.phrase = "A short circuit"
  hvp.part_id = "world"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 4
  hvp.phrase = "\"With this ring I thee wed.\""
  hvp.part_id = "world"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 1
  hvp.phrase = "A baby"
  hvp.part_id = "world"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 18
  hvp.phrase = "Torture a person in a concentration camp"
  hvp.part_id = "world"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 2
  hvp.phrase = "Love of Nature"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 14
  hvp.phrase = "A madman"
  hvp.part_id = "world"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 8
  hvp.phrase = "An assembly line"
  hvp.part_id = "world"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 15
  hvp.phrase = "Slavery"
  hvp.part_id = "world"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 3
  hvp.phrase = "A mathematical genius"
  hvp.part_id = "world"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 7
  hvp.phrase = "A uniform"
  hvp.part_id = "world"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 6
  hvp.phrase = "I like my work - it does me good."
  hvp.part_id = "self"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 9 
  hvp.phrase = "The universe is a remarkably harmonious system."
  hvp.part_id = "self"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 10
  hvp.phrase = "The world makes little sense to me."
  hvp.part_id = "self"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 11
  hvp.phrase = "No matter how hard I work, I shall always feel frustrated."
  hvp.part_id = "self"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 13
  hvp.phrase = "My working conditions are poor, and ruin my work."
  hvp.part_id = "self"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 5 
  hvp.phrase = "I feel at home in the world."
  hvp.part_id = "self"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 17
  hvp.phrase = "I hate my work."
  hvp.part_id = "self"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 16
  hvp.phrase = "My life is messing up the world."
  hvp.part_id = "self"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 12
  hvp.phrase = "My work contributes nothing to the world."
  hvp.part_id = "self"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 4
  hvp.phrase = "My work brings out the best in me."
  hvp.part_id = "self"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 1
  hvp.phrase = "I enjoy being myself."
  hvp.part_id = "self"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 18
  hvp.phrase = "I curse the day I was born."
  hvp.part_id = "self"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 2
  hvp.phrase = "I love my work."
  hvp.part_id = "self"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 14
  hvp.phrase = "The lack of meaning in the universe disturbs me."
  hvp.part_id = "self"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 8
  hvp.phrase = "The more I understand my place in the world, the better I get in my work."
  hvp.part_id = "self"
  hvp.category_id = "extrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 15
  hvp.phrase = "My work makes me unhappy."
  hvp.part_id = "self"
  hvp.category_id = "intrinsic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 3
  hvp.phrase = "I love the beauty of the world."
  hvp.part_id = "self"
  hvp.category_id = "systemic"
end

HvpMaster.create do |hvp|
  hvp.axiological_norm = 7
  hvp.phrase = "My work adds to the beauty and harmony of the world."
  hvp.part_id = "self"
  hvp.category_id = "systemic"
end
