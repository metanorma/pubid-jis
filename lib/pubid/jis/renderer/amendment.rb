require_relative "base"

module Pubid::Jis::Renderer
  class Amendment < Base
    def render_identifier(params)
      "%{base}/AMD %{number}%{year}" % params
    end
  end
end
