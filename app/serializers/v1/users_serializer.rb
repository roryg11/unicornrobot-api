module V1
  class UsersSerializer < ActiveModel::Serializer
    attributes :id, :username, :first_name, :last_name, :jump_from, :jump_to, :email, :created_at, :bio, :interests
  end
end
