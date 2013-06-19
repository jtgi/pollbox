object @room
attributes :id, :name, :description

if current_user.owns_room?(@room.id)
	node(:edit_url){ |room| edit_room_path(room) }
end

node(:vote_subscription){ |room| subscribe_to "/vote/#{room.name}"}
node(:question_subscription){ |room| subscribe_to "/question/#{room.name}"}

child (:questions) do
	attributes :user_id, :title, :body
	node(:view_question) { |question| question_path(question) }
end


