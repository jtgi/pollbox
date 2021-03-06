FactoryGirl.define do 
	factory :user do
		first_name "foo"
		last_name "bar"
		sequence(:email) { |n| "foobar#{n}@example.com" }
		password "foobar"
		password_confirmation "foobar"
		factory :admin do
			admin true
		end
	end

	factory :room do
		sequence(:name) { |n| "room#{n}" }
		description "Description of room"
		maximum_registrants 200		
		factory :protected_room do
			pass_code "password"
		end
	end

	factory :subscription do
		user
		room
		user_level 0
		factory :owned_subscription do
			user_level 3
		end
	end

	factory :poll do
		sequence(:title) { |n| "poll#{n}" }
		sequence(:body) { |n| "poll body number: #{n}" }
		user
		room
    open true
    factory :closed_poll do
      open false
    end


	end
	factory :poll_option do
		sequence(:option) { |n| "poll option #{n}" }
		poll
	end

	factory :vote do
		user
		poll_option
	end
end

