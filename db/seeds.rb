# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

card = Card.create(title: 'Exercises', goal: 10)
[
  { title: 'Eyes', score: 1 },
  { title: 'Compensatory', score: 1 },
  { title: 'Flexibility', score: 1 },
  { title: 'Yoga (4m)', score: 1 },
  { title: 'Isometric', score: 1 },
  { title: 'Agil/Coord/Bal', score: 1 },
  { title: 'Gen act (100m)', score: 1 },
  { title: 'Phy jobs (30m)', score: 1 },
  { title: 'MoJ stairs', score: 1 },
  { title: 'BJJ home drills', score: 1 },
  { title: 'Calisthenics', score: 1 },
  { title: 'Pullups', score: 1 },
  { title: 'Explosive', score: 1 },
  { title: 'Kettlebell', score: 1 },
  { title: 'BJJ class (5m)', score: 1 },
  { title: 'HIIT (3x25s)', score: 1 },
  { title: 'Run (5m)', score: 1 }
].each do |item|
  card.items.create(item)
end

card = Card.create(title: 'Nutrition', goal: 10)
[
  { title: 'Beans', score: 1 },
  { title: 'Cruc', score: 1 },
  { title: 'Berries', score: 1 },
  { title: 'Fruits', score: 1 },
  { title: 'Veg', score: 1 },
  { title: 'Leaves', score: 1 },
  { title: 'Flax', score: 1 },
  { title: 'Nuts/seeds', score: 1 },
  { title: 'Herbs/sp', score: 1 },
  { title: 'Whole gr', score: 1 },
  { title: 'Vit B12', score: 0.5 },
  { title: 'Vit D', score: 0.5 },
  { title: 'Bev (250ml)', score: 0.25 },
  { title: 'Refined carbs', score: -1 },
  { title: 'Dairy', score: -1 },
  { title: 'Sweet', score: -1 },
  { title: 'Salty', score: -1 },
  { title: 'Poultry', score: -1 },
  { title: 'Red meat', score: -1 }
].each do |item|
  card.items.create(item)
end

card = Card.create(title: 'Calories', goal: 10)
[
  { title: 'BJJ class 1h', score: -350 },
  { title: 'Phys job 30 min', score: -150 },
  { title: 'Run 10 min', score: -130 },
  { title: 'Gen act 25 min', score: -105 },
  { title: 'Biscuit/Wine', score: 100 },
  { title: 'Takeaway/Rest', score: 300 },
  { title: 'Snack', score: 350 },
  { title: 'Sweet', score: 450 }
].each do |item|
  card.items.create(item)
end

card = Card.create(title: 'Social', goal: 10)
[
  { title: 'Speak to stranger face to face', score: 1 },
  { title: 'Schedule social event', score: 1 },
  { title: 'Attend social event', score: 1 },
  { title: 'Help someone', score: 1 },
  { title: '1 to 1 with a friend', score: 1 },
  { title: 'Read', score: 1 },
  { title: 'Post tweet/FB', score: 1 }
].each do |item|
  card.items.create(item)
end