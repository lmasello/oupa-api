class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :type, :device_token, :created_at
end
