class Private::LocationsController < Private::PrivateApiController

  before_action :set_country, only: [:index]

  def index
    @locations = Location.joins(:location_relations)
                     .where(location_relations: { location_group: @country
                                                                      .location_groups.joins(:location_relations) } )
                     .uniq


    json_response_location(@locations, true)

  end

  private

  def set_country
    panel_provider = PanelProvider.find_by!(id: params[:provider_id])
    @country = panel_provider.countries.find_by!(code: params[:country_code])
  end

end
