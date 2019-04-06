# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
card = Card.create(title: 'Exercises', goal: 10)
card.items.create(title: 'Eyes', min: 1, period: 1, score: 1)
card.items.create(title: 'Push ups', min: 1, period: 1, score: 1)
card.items.create(title: 'BJJ class', min: 1, period: 1, score: 5)

Card.create(title: 'Calories', goal: 10)
Card.create(title: 'Nutrition', goal: 10)
Card.create(title: 'Social', goal: 10)
