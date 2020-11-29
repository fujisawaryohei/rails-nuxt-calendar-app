class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :is_done, :date
  attribute :time do
    unless object.time.nil?
      object.time.strftime("%R")
    end
  end
end
