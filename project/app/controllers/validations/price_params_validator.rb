class Validations::PriceParamsValidator

  include ActiveModel::Validations

  attr_accessor :country_code, :target_group_id, :locations
  attr_accessor :country

  validates :country_code, presence: true
  validates :target_group_id, presence: true
  validates :locations, presence: true
  validates_length_of :locations, minimum: 10
  validate :country_integrity
  validate :target_group_integrity
  validate :locations_integrity


  def initialize(params = ActionController::Parameters.new)
    @country_code = params[:country_code]
    @target_group_id = params[:target_group_id]
    @locations = params[:locations]

    params.require(:pricing).permit(:country_code, :target_group_id,
                                                    :locations)
  end

  private

  def country_integrity

    @country = Country.find_by(code: @country_code)

    unless @country.present?
      errors.add(:country_code, 'Invalid country code')
      return
    end

    loc_groups = LocationGroup.where(country_id: @country.id).includes(:locations)

    @country_location_ids = []

    loc_groups.each do |loc_group|
      @country_location_ids += loc_group.locations.collect(&:id)
    end

    @country_location_ids.uniq!
  end

  def target_group_integrity

    unless TargetGroup.find_by(id: @target_group_id).present?
      errors.add(:panel_provider_id, 'Invalid Target Group')
    end


  end

  def locations_integrity

    return unless @country.present?

    if @locations.empty?
      errors.add(:locations, 'Invalid Locations Format')
      return
    end

    loc_ids = @locations.map { |entry| entry['id'] }
    loc_ids.uniq!

    unless (loc_ids & @country_location_ids) == loc_ids
      errors.add(:locations, 'Locations must belong to selected country')
    end

  end
end