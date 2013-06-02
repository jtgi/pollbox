collection @rooms
attributes :id, :name, :description
node(:show_path) { |room| room_path(room) }
node(:owned) { |room| current_user.owns_room(room.id) }

