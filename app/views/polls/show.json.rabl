object @poll
attributes :id, :title, :body

child(:poll_options) do
	attributes :id, :option
	node(:votes) { |poll_option| poll_option.votes.size }
	node(:correct) { |poll_option| poll_option.correct? }
end