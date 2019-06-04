# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

card = Card.create(title: 'Exercise', description: 'Here is the description', goal: 10)
[
  { title: 'Yoga (4m)', description: 'Here is the description', score: 1 },
  { title: 'Isometric',description: 'Here is the description',  score: 1 },
  { title: 'Agil/Coord/Balance', description: 'Here is the description', score: 1 },
  { title: 'Calisthenics', description: 'Here is the description', score: 1 },
  { title: 'Pullups', description: 'Here is the description', score: 1 },
  { title: 'Kettlebell', description: 'Here is the description', score: 1 },
  { title: 'Run (5m)', description: 'Here is the description', score: 1 }
].each do |item|
  card.items.create(item)
end

card = Card.create(title: 'Eat healthy', description: 'Here is the description', goal: 10)
[
  { title: 'Berries', description: 'Here is the description', score: 1 },
  { title: 'Fruits', description: 'Here is the description', score: 1 },
  { title: 'Veg', description: 'Here is the description', score: 1 },
  { title: 'Leaves', description: 'Here is the description', score: 1 },
  { title: 'Nuts/seeds', description: 'Here is the description', score: 1 },
  { title: 'Whole gr', description: 'Here is the description', score: 1 },
  { title: 'Refined carbs', description: 'Here is the description', score: -1 },
  { title: 'Sweet', description: 'Here is the description', score: -1 },
  { title: 'Salty', description: 'Here is the description', score: -1 }
].each do |item|
  card.items.create(item)
end
