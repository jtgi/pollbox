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

@room3 = Room.new(:name=>"Test Room", :description=>"Description of Test's room", :maximum_registrants=>100)
@room3.owner_id = 3
@room3.save

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

@registration4 = Registration.new
@registration4.room_id = 2
@registration4.user_id = 1
@registration4.user_level = 0
@registration4.save

@registration5 = Registration.new
@registration5.room_id = 2
@registration5.user_id = 2
@registration5.user_level = 1
@registration5.save

@registration6 = Registration.new
@registration6.room_id = 2
@registration6.user_id = 3
@registration6.user_level = 0
@registration6.save

#create first poll in Chris' Room
@poll1 = Poll.new(:title=>"What is a lock?", :body=>"Body for lock question")
@poll1.room_id = 1
@poll1.user_id = 1
@poll1.save

@poll2 = Poll.new(:title=>"Is anyone having a hard time with this class?", :body=>"Just wondering if everyone is keeping up")
@poll2.room_id = 1
@poll2.user_id = 1
@poll2.save

@pollOption1 = PollOption.new(:option=>"Lock option 1")
@pollOption1.poll_id = 1
@pollOption1.save

@pollOption2 = PollOption.new(:option=>"Lock option 2")
@pollOption2.poll_id = 1
@pollOption2.save

@pollOption3 = PollOption.new(:option=>"Lock option 3")
@pollOption3.poll_id = 1
@pollOption3.save

@pollOption4 = PollOption.new(:option=>"Yes everything is fine")
@pollOption4.poll_id = 2
@pollOption4.save

@pollOption5 = PollOption.new(:option=>"Its kinda ok")
@pollOption5.poll_id = 2
@pollOption5.save

@pollOption6 = PollOption.new(:option=>"No its too hard")
@pollOption6.poll_id = 2
@pollOption6.save

@vote1 = Vote.new
@vote1.user_id = 1
@vote1.poll_option_id = 2
@vote1.save

@vote2 = Vote.new
@vote2.user_id = 2
@vote2.poll_option_id = 1
@vote2.save

@vote3 = Vote.new
@vote3.user_id = 3
@vote3.poll_option_id = 1
@vote3.save

#create questions
@question1 = Question.new(:title=>"My First question", :body=>"What is a biology?")
@question1.user_id = 2
@question1.room_id = 1
@question1.save

@answer1 = Answer.new(:title=>"Answer to your first question", :body=>"Thats not a word")
@answer1.user_id = 1
@answer1.question_id = 1
@answer1.save

@question2 = Question.new(:title=>"What class is this?", :body=>"Word")
@question2.user_id = 2
@question2.room_id = 1
@question2.save

@answer2 = Answer.new(:title=>"Answer to your first question", :body=>"Thats not a word")
@answer2.user_id = 3
@answer2.question_id = 2
@answer2.save
