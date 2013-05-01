collection @rooms
attributes :id, :name, :description
node(:show_path) { |room| room_path(room) }
node(:owned) { |room| current_user.id == room.owner_id }

