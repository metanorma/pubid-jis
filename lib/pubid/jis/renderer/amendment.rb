require_relative "base"

module Pubid::Jis::Renderer
  class Amendment < Base
    def render_identifier(params)
      "%{base}/AMD %{number}%{year}" % params
    end

    def render_base(base, opts, _params)
      base.to_s(**opts)
    end
  end
end
