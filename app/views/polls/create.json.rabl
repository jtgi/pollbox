object @poll

if @poll.errors.count > 0
  node(:errors){ |poll| poll.errors.to_json }
else
  attributes :id, :title, :body
end
