# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ADJS = %w(hot big small freaky torpid antique blue red green rainbow).to_a
ADJS += %w(black white cray_cray few shiny smug slight vapid wild wild).to_a
NOUNS = %w(dog cat turtle ostrich teacher boy girl monkey ice fire cape).to_a
NOUNS += %w(doctor coder plumber gamer doom flower star key suit hippo).to_a
CATEGORIES = %w(grammar cute humor science games hobbies dreams poetry).to_a
DESCRIPTORS= %w(awesome great mediocre funny hardcore puny fail depressing).to_a

def make_users(num = 5)
	users_array = []
	num.times do
		user = User.new(username: ADJS.sample.capitalize+"_"+NOUNS.sample.capitalize,
						password: ADJS.sample+ADJS.sample+NOUNS.sample)
		if user.save
			user.reset_session!
			users_array << user
		end
	end
	users_array
end

def rand_links(user_id)#<--TODO figure out if user should be random
  subs = Sub.all
  5.times do
  	sub = subs.sample
    title = "#{ADJS.sample.capitalize} #{NOUNS.sample} has #{DESCRIPTORS.sample} #{sub.name.downcase}" #<-- RANDOMIZE (Maybe base on title sub title?)
    url = "www.lmgtfy.com/?"+title.gsub(" ", "+")+"&l=1"
    desc = "This site is not liable for where this link may take you"
    sub_id = sub.id
    Link.create(title: title, url: url, desc: desc, user_id: user_id, sub_id: sub_id)
  end
end

def generate_subs
	user_ids = User.pluck(:id)
	sub_titles = Sub.pluck(:name)
	CATEGORIES.each do |cat|
		next if sub_titles.include?(cat.capitalize)
		Sub.create(mod_id: user_ids.sample, name: cat.capitalize)
	end
end

def generate_comments
	links = Link.all
	user_ids = User.pluck(:id)
	5.times do
		link = links.sample
		parent_comment_id = ([nil] + link.comment_ids).sample
		body = "That #{link.title.split(" ")[1]} was #{DESCRIPTORS.sample}"
		user_id = user_ids.sample
		link_id = link.id
		Comment.create(parent_comment_id: parent_comment_id, user_id: user_id,
									 link_id: link_id, body: body)
	end
end

def generate_votes
	user_ids = User.pluck(:id)
	link_ids = Link.pluck(:id)
	50.times do
		user_id = user_ids.sample
		link_id = link_ids.sample
		Vote.create(value: 1, user_id: user_id, link_id: link_id)
	end
end


3.times{ make_users }
generate_subs
7.times do
	user_id= User.pluck(:id).sample
	rand_links(user_id)
end
15.times{ generate_comments }
generate_votes