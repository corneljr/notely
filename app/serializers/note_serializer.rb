class NoteSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :category_id
end
