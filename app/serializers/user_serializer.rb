class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :type, :created_at
end
