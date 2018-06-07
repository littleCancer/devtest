module Calculators::CalculatorFactory

  TYPES = {
      1 => CharacterBasedCalculator,
      2 => JsonBasedCalculator,
      3 => NodesBasedCalculator
  }

  private_constant :TYPES

  def self.for(panel_provider)

    TYPES[panel_provider.id].new

  end


end