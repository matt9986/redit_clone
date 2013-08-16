# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ADJS = w%(hot big small freaky torpid antique blue red green rainbow).to_a
ADJS += w%(black white cray_cray few shiny smug slight vapid wild wild).to_a
NOUNS = w%(dog cat turtle ostrich teacher boy girl monkey ice fire cape).to_a
NOUNS += w%(doctor coder plumber gamer doom flower star key suit hippo).to_a
def make_users(num = 5)
	users_array = []
	num.times do
		user = {username: ADJS.sample.capitalize+"_"+NOUNS.sample.capitalize,
						password: ADJS.sample+ADJS.sample+NOUNS.sample}
		if user.save
			user.session_reset!
			users_array << user
		end
	end
	users_array
end

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