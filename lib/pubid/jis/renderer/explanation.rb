require_relative "base"

module Pubid::Jis::Renderer
  class Explanation < Base
    def render_identifier(params)
      if params[:number].to_s.empty?
        "%{base}/EXPL" % params
      else
        "%{base}/EXPL %{number}" % params
      end
    end
  end
end
