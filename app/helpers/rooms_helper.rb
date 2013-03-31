module RoomsHelper
	def userIsRegistered(user, roomId)
		room = Room.find(roomId)
		userRooms = user.room
		userRooms.include? room
	end

	def rooms_level_by_id(user, level)
		room_ids = []
		registrations = user.registration.where("user_level = ?", level)
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
end
