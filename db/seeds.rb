# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
["Art", "Automotive", "Beauty", "Business", "Comedy", "Education", "Entertainment", "Family","Fashion", "Food", "Gaming", "Health", "Lifestyle", "Men", "Movies & TV", "Music", "News", "Pets & Animals", "Photography", "Politics"].each do |cat|
  c = Category.new(name: cat)
  c.save
end
all_categories = Category.all

["Art", "Automotive", "Beauty", "Business", "Comedy"].each do |tag|
  tag = Tag.new(name: tag)
  tag.save
end
all_tags = Tag.all
