require_relative "base"

module Pubid::Jis::Renderer
  class TechnicalReport < Base
    def render_identifier(params)
      "%{publisher} TR%{series} %{number}%{part}%{year}%{all_parts}" % params
    end
  end
end
