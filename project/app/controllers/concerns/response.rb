module Response

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_response_location(object, private = false, status = :ok)
    render json: object, status: status,
           each_serializer: (private ? LocationPrivateSerializer : LocationSerializer)
  end

  def json_response_target_group(object, private = false, status = :ok)
    render json: object, status: status,
           each_serializer: (private ? TargetGroupPrivateSerializer : TargetGroupSerializer)
  end


end