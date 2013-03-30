module ApplicationHelper
	def full_title(page_title)
		base_title = "Roomfeed"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def userIsRegistered(user, roomId)
		room = Room.find(roomId)
		userRooms = user.room
		userRooms.include? room
	end

end
