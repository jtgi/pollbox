# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#create 3 users

User.create(:first_name=>"Chris", :last_name=>"Zhu", :email=>"chris@example.com", :password=>"chrispass", :password_confirmation=>"chrispass")
User.create(:first_name=>"John", :last_name=>"Giannakos", :email=>"john@example.com", :password=>"johnpass", :password_confirmation=>"johnpass")
User.create(:first_name=>"Test", :last_name=>"Test", :email=>"test@example.com", :password=>"testpass", :password_confirmation=>"testpass")

#create 2 rooms
@room1 = Room.new(:name=>"Chris' Room", :description=>"Description of my room", :maximum_registrants=>200)
@room1.owner_id = 1
@room1.save

@room2 = Room.new(:name=>"John's Room", :description=>"Description of John's Room", :maximum_registrants=>250)
@room2.owner_id = 2
@room2.save

#create registrations
@registration1 = Registration.new
@registration1.room_id = 1
@registration1.user_id = 1
@registration1.user_level = 1
@registration1.save

@registration2 = Registration.new
@registration2.room_id = 1
@registration2.user_id = 2
@registration2.user_level = 0
@registration2.save

@registration3 = Registration.new
@registration3.room_id = 1
@registration3.user_id = 3
@registration3.user_level = 0
@registration3.save


#create first poll in Chris' Room
@poll = Poll.new(:title=>"What is a lock?", :body=>"Body for lock question")
@poll.room_id = 1
@poll.user_id = 1
@poll.save

@pollOption1 = PollOption.new(:option=>"Lock option 1")
@pollOption1.poll_id = 1
@pollOption1.save

@pollOption2 = PollOption.new(:option=>"Lock option 2")
@pollOption2.poll_id = 1
@pollOption2.save

@pollOption3 = PollOption.new(:option=>"Lock option 3")
@pollOption3.poll_id = 1
@pollOption3.save

@vote1 = Vote.new
@vote1.user_id = 1
@vote1.poll_option_id = 2

@vote2 = Vote.new
@vote2.user_id = 2
@vote2.poll_option_id = 1

@vote3 = Vote.new
@vote3.user_id = 3
@vote3.poll_option_id = 1







