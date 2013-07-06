# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#create 3 users
userIDs = []
roomIDs = []

def rand_prob(prob)
  random_num = rand(100)
  return random_num < prob
end

#create Users
for i in 0..5
  user = User.create(:first_name=>"first #{i}", :last_name=>"last #{i}", :email=>"user#{i}@example.com", :password=>"password")
  userIDs.push(user.id)
end
#create rooms with one owner, for other users, 70% probability they sub to that room
userIDs.each do |id|
  user = User.find(id)
  room = user.rooms.create(:name=>"User #{id}'s Room")
  sub = room.subscriptions.first
  sub.user_level = 3
  sub.save

  roomIDs.push(room.id)
  
  userIDs.each do |sub_id|
    next if sub_id == id
    if rand_prob(70)
      sub_user = User.find(sub_id)
      sub = Subscription.new
      sub.user_id = sub_user.id
      sub.room_id = room.id
      sub.save
    end
  end
end

#creating questions: users of each room has 70% prob of asking a question
roomIDs.each do |room_id|
  room = Room.find(room_id)
  room_users = room.users
  room_users.each do |user|
    next if user.owns_room?(room)
    if rand_prob(70)
      question = Question.new(:title=>"Question from user #{user.id}", :body=>"My Body")
      question.user = user
      question.room = room
      question.save
    end
  end
end

#for each question of each room, create answers
roomIDs.each do |room_id|
  room = Room.find(room_id)
  questions = room.questions
  users = room.users
  questions.each do |question|
    users.each do |user|
      next if question.user == user
      if rand_prob(70)
        answer = Answer.new(:title=>"Answer from user #{user.id}", :body=>"This is the answer to your question")
        answer.user = user
        answer.question = question
        answer.save
      end
    end
  end
end

##create 2 rooms
#@room1 = Room.new(:name=>"Chris' Room", :description=>"Description of my room", :maximum_registrants=>200)
#@room1.save
#
#@room2 = Room.new(:name=>"John's Room", :description=>"Description of John's Room", :maximum_registrants=>250)
#@room2.save
#
#@room3 = Room.new(:name=>"Test Room", :description=>"Description of Test's room", :maximum_registrants=>100)
#@room3.save
#
##create registrations
#@registration1 = Registration.new
#@registration1.room_id = 1
#@registration1.user_id = 1
#@registration1.user_level = 3
#@registration1.save
#
#@registration2 = Registration.new
#@registration2.room_id = 1
#@registration2.user_id = 2
#@registration2.user_level = 0
#@registration2.save
#
#@registration3 = Registration.new
#@registration3.room_id = 1
#@registration3.user_id = 3
#@registration3.user_level = 0
#@registration3.save
#
#@registration4 = Registration.new
#@registration4.room_id = 2
#@registration4.user_id = 1
#@registration4.user_level = 0
#@registration4.save
#
#@registration5 = Registration.new
#@registration5.room_id = 2
#@registration5.user_id = 2
#@registration5.user_level = 3
#@registration5.save
#
#@registration6 = Registration.new
#@registration6.room_id = 2
#@registration6.user_id = 3
#@registration6.user_level = 0
#@registration6.save
#
##create first poll in Chris' Room
#@poll1 = Poll.new(:title=>"What is a lock?", :body=>"Body for lock question")
#@poll1.room_id = 1
#@poll1.user_id = 1
#@poll1.save
#
#@poll2 = Poll.new(:title=>"Is anyone having a hard time with this class?", :body=>"Just wondering if everyone is keeping up")
#@poll2.room_id = 1
#@poll2.user_id = 1
#@poll2.save
#
#@pollOption1 = PollOption.new(:option=>"Lock option 1")
#@pollOption1.poll_id = 1
#@pollOption1.save
#
#@pollOption2 = PollOption.new(:option=>"Lock option 2")
#@pollOption2.poll_id = 1
#@pollOption2.save
#
#@pollOption3 = PollOption.new(:option=>"Lock option 3")
#@pollOption3.poll_id = 1
#@pollOption3.save
#
#@pollOption4 = PollOption.new(:option=>"Yes everything is fine")
#@pollOption4.poll_id = 2
#@pollOption4.save
#
#@pollOption5 = PollOption.new(:option=>"Its kinda ok")
#@pollOption5.poll_id = 2
#@pollOption5.save
#
#@pollOption6 = PollOption.new(:option=>"No its too hard")
#@pollOption6.poll_id = 2
#@pollOption6.save
#
#@vote1 = Vote.new
#@vote1.user_id = 1
#@vote1.poll_option_id = 2
#@vote1.save
#
#@vote2 = Vote.new
#@vote2.user_id = 2
#@vote2.poll_option_id = 1
#@vote2.save
#
#@vote3 = Vote.new
#@vote3.user_id = 3
#@vote3.poll_option_id = 1
#@vote3.save
#
##create questions
#@question1 = Question.new(:title=>"My First question", :body=>"What is a biology?")
#@question1.user_id = 2
#@question1.room_id = 1
#@question1.save
#
#@answer1 = Answer.new(:title=>"Answer to your first question", :body=>"Thats not a word")
#@answer1.user_id = 1
#@answer1.question_id = 1
#@answer1.save
#
#@question2 = Question.new(:title=>"What class is this?", :body=>"Word")
#@question2.user_id = 2
#@question2.room_id = 1
#@question2.save
#
#@answer2 = Answer.new(:title=>"Answer to your first question", :body=>"Thats not a word")
#@answer2.user_id = 3
#@answer2.question_id = 2
#@answer2.save
