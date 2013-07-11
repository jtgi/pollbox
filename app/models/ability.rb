class Ability
  include CanCan::Ability

  def initialize(user)
	
	#Room permissions
	can :create, Room

	#can [:destroy, :update], Room, :user_id=>user.id
  can [:destroy, :update], Room do |room|
    user.owns_room?(room.id)
  end

	#can :read, Room do |room|
	#	#user.is_subscribed_to(room.id)
	#	#the function is subscribed to no longer makes any sense
	#	
	#end

	#Poll permissions
	can :read, Poll do |poll|
		user.is_subscribed_to(poll.room_id) || user.owns_poll?(poll.id)
	end

	can [:update, :destroy, :create], Poll do |poll|
		user.owns_room?(poll.room_id)
	end

	#can [:update, :destroy], Poll, :user_id=>user.id
	
	can :show, Poll do |poll|
		user.is_subscribed_for(poll.room_id)
	end

	#Poll Option Permissions
	can [:read, :create], PollOption do |pollOption|
		user.is_subscribed_for(pollOption.poll.room_id)
	end

	can [:update, :destroy], PollOption do |pollOption|
		pollOption.poll.user_id == user.id
	end
	
	#Question Permissions
	can [:read, :create], Question do |question|
		user.is_subscribed_for(question.room_id)
	end
	can [:update, :destroy], Question, :user_id=>user.id

	#Answer Permissions
	can [:read, :create], Answer do |answer|
		user.is_subscribed_for(answer.question.room_id)
	end

	can [:update, :destroy], Question, :user_id=>user.id

	#Subscription permissions

	can [:read, :update, :destroy], Subscription do |subscription|
		user.id == subscription.user_id || user.owns_room?(subscription.room.id)
	end

  end
end
