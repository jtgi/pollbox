object @room
attributes :id, :name, :maximum_registrants

if @room.valid?
	node(:errors) { |o| o.errors }
end
