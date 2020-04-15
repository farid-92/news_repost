class PostSerializer < ActiveModel::Serializer
  attributes :id, :id, :title, :content, :author, :created_at

  def created_at
    object.created_at.strftime("%d-%m-%Y")
  end

end
