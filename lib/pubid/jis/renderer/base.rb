module Pubid::Jis::Renderer
  class Base < Pubid::Core::Renderer::Base
    TYPE = "".freeze

    def render_identifier(params)
      "%{publisher}%{series} %{number}%{part}%{year}%{all_parts}" % params
    end

    def render_publisher(publisher, opts, params)
      super if opts[:with_publisher]
    end

    def render_series(series, opts, _params)
      opts[:with_publisher] ? " #{series}" : series
    end

    def render_part(part, opts, _params)
      return "-#{part.reverse.join('-')}" if part.is_a?(Array)

      "-#{part}"
    end

    def render_all_parts(all_parts, _opts, _params)
      "（規格群）" if all_parts
    end
  end
end
