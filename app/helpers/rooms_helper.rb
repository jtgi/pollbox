module RoomsHelper
	def userIsRegistered(user, room_id)
		room = Room.find(room_id)
		userRooms = user.rooms
		userRooms.include? room
	end
end
