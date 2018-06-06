class Private::TargetGroupsController < ApplicationController

  before_action :set_country, only: [:index]

  def index
    @all_country_groups = []
    @country.target_groups.each do |tg|
      @all_country_groups += tg.self_and_descendants
    end

    json_response_target_group(@all_country_groups, true)
  end

  private

  def set_country
    panel_provider = PanelProvider.find_by!(id: params[:provider_id])
    country = panel_provider.countries.find_by!(code: params[:country_code])
    @country = country
  end

end
