object @poll
attributes :id, :title, :body

child(:poll_options) do
	attributes :option
	node(:votes) { |poll_option| poll_option.votes.size }
end
