class Ability
  include CanCan::Ability

  def initialize(user)
	
	#Room permissions
	can :create, Room

	can [:destroy, :update], Room, :user_id=>user.id

	can :read, Room do |room|
		user.is_registered_for(room.id)
	end

	#Poll permissions
	can :read, Poll do |poll|
		user.is_registered_for(poll.room_id) || user.owns_poll?(poll.id)
	end

	can :create, Poll do |poll|
		user.owns_room?(poll.room_id)
	end

	can [:update, :destroy], Poll, :user_id=>user.id
	
	can :show, Poll do |poll|
		user.is_registered_for(poll.room_id)
	end

	#Poll Option Permissions
	can [:read, :create], PollOption do |pollOption|
		user.is_registered_for(pollOption.poll.room_id)
	end

	can [:update, :destroy], PollOption do |pollOption|
		pollOption.poll.user_id == user.id
	end
	
	#Question Permissions
	can [:read, :create], Question do |question|
		user.is_registered_for(question.room_id)
	end
	can [:update, :destroy], Question, :user_id=>user.id

	#Answer Permissions
	can [:read, :create], Answer do |answer|
		user.is_registered_for(answer.question.room_id)
	end

	can [:update, :destroy], Question, :user_id=>user.id

	
  end
end
