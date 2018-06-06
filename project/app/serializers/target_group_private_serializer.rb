class TargetGroupPrivateSerializer < ActiveModel::Serializer
  attributes :name, :external_id, :panel_provider_id, :secret_code
end
