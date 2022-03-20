# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = ["Pantry", "Fridge", "Frozen", "Breakfast", "Lunch", "Dinner"]

if Category.count == 0 
    categories.each do |c|
        Category.create(name: c)
        puts "created #{c} category"
    end
end

dietry_choices = ["Vegan", "Vegetarian", "Dairy Free", "Egg Free", "Nut Free", "Gluten Free"]

if Dietry.count == 0
    dietry_choices.each do |d|
        Dietry.create(name: d)
        puts "created #{d} dietry choice"
    end
end 