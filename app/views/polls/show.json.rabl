object @poll
attributes :id, :title, :body

child(:poll_options) do
	attributes :id, :option
	node(:votes) { |poll_option| poll_option.votes.size }
	node(:correct) { |poll_option| poll_option.correct? }
  node(:voted){ |poll_option| current_user.voted_for?(poll_option) }
end
