object @question
attributes :id, :title, :body


if @question.errors.count > 0
  node(:errors) { |question| question.errors.to_json }


