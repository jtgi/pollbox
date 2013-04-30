object @room
attributes :id, :name, :description

if current_user.owns_room?(@room.id)
	node(:edit_url){ edit_room_path(@room) }
end

