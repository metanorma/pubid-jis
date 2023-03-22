require 'forwardable'

module Pubid::Jis
  module Identifier
    class Base < Pubid::Core::Identifier::Base
      attr_accessor :series
      extend Forwardable

      def self.type
        { key: :jis, title: "Japanese Industrial Standard" }
      end

      # @param month [Integer] document's month
      # @param edition [String] document's edition version, e.g. "3.0", "1.0"
      def initialize(publisher: "JIS", series: nil, part: nil, **opts)
        super(**opts.merge(publisher: publisher))
        @series = series if series
        @part = part if part
      end

      class << self
        # Use Identifier#create to resolve identifier's type class
        def transform(params)
          identifier_params = params.map do |k, v|
            get_transformer_class.new.apply(k => v)
          end.inject({}, :merge)

          Identifier.create(**identifier_params)
        end

        def get_parser_class
          Parser
        end

        def get_renderer_class
          Renderer::Base
        end
      end
    end
  end
end
