module RoomsHelper
	def userIsRegistered(user, room_id)
		room = Room.find(room_id)
		userRooms = user.rooms
		userRooms.include? room
	end

	def rooms_level_by_id(user, level)
		room_ids = []
		registrations = user.registrations.where("user_level = ?", level)
		if registrations.nil?
			return nil
		else
			registrations.each do |reg|
				room_ids.push(reg.id)
			end
		end
		return room_ids
	end

	def get_rooms_by_id(room_ids)
		rooms = []
		room_ids.each do |id|
			rooms.push(Room.find(id))
		end
		return rooms
	end

	def find_room_owner_id(room_id)
		room = Rooms.find(room_id)
		return room.id
	end
end
