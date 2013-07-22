object @room
attributes :id, :name, :description

if @room.errors.count > 0
  node(:errors) { |room| room.errors.to_json }

else
  node(:owned) { |room| current_user.owns_room?(@room.id) }
  
  node(:vote_subscription){ |room| subscribe_to "/#{room.name}/master"}
  
  child (:questions) do
  	attributes :user_id, :title, :body
  	node(:view_question) { |question| question_path(question) }
  end

end


