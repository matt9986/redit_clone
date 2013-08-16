# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def rand links(user_id)#<--TODO figure out if user should be random
  sub_ids = Sub.pluck(:id)
  5.times do
    title = "" #<-- RANDOMIZE (Maybe base on title sub title?)
    url = "www.lmgtfy.com/?"+title.gsub(" ", "+")+"&l=1"
    desc = "This site is not liable for where this link may take you"
    sub_id = sub_ids.sample
    Link.create(title: title, url: url, desc: desc,
                user_id: user_id, sub_id: sub)
  end
end