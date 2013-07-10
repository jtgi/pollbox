object @question
attributes :id, :title, :body, :user_id

if current_user.owns_question?(@question.id)
	node(:edit_url) { |question| edit_question_path(question) }
end

child (:answers) do
	attributes :user_id, :title, :body
	node(:view_answer) { |answer| answer_path(answer) }
end
