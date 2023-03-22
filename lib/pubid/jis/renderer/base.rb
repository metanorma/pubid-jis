module Pubid::Jis::Renderer
  class Base < Pubid::Core::Renderer::Base
    TYPE = "".freeze

    def render_identifier(params)
      "%{publisher}%{series} %{number}%{part}%{year}" % params
    end

    def render_series(series, _opts, _params)
      " #{series}"
    end

    def render_part(part, opts, _params)
      return "-#{part.reverse.join('-')}" if part.is_a?(Array)

      "-#{part}"
    end
  end
end
