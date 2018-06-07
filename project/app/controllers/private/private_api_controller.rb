class Private::PrivateApiController < ApplicationController

  before_action :check_user

  def check_user
    raise(AppExceptionHandler::Forbidden, 'Forbidden') unless @current_user.panel_provider_id
  end

end
