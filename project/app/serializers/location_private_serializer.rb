class LocationPrivateSerializer < ActiveModel::Serializer
  attributes :name, :external_id, :secret_code
end
