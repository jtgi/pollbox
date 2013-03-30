module RoomsHelper
	def userIsRegistered(user, roomId)
		room = Room.find(roomId)
		userRooms = user.room
		userRooms.include? room
	end

	def hello
	end
end
