require_relative "base"

module Pubid::Jis::Renderer
  class TechnicalSpecification < Base
    def render_identifier(params)
      "%{publisher} TS%{series} %{number}%{part}%{year}%{all_parts}" % params
    end
  end
end
