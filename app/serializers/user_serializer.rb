class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :type, :device_token, :created_at
end
