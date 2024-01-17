require 'forwardable'

module Pubid::Jis
  module Identifier
    class Base < Pubid::Core::Identifier::Base
      attr_accessor :series, :all_parts
      extend Forwardable

      def self.type
        { key: :jis, title: "Japanese Industrial Standard" }
      end

      # @param month [Integer] document's month
      # @param edition [String] document's edition version, e.g. "3.0", "1.0"
      def initialize(publisher: "JIS", series: nil, part: nil, all_parts: false, **opts)
        super(**opts.merge(publisher: publisher))
        @series = series if series
        @part = part if part
        @all_parts = all_parts
      end

      def all_parts?
        all_parts
      end

      def ==(other)
        if all_parts? || other.all_parts?
          return to_h.reject { |k, _| [:year, :part, :all_parts].include?(k) } ==
            other.to_h.reject { |k, _| [:year, :part, :all_parts].include?(k) }
        end

        super
      end

      # @param with_publisher [Boolean] add publisher to output
      def to_s(with_publisher: true)
        options = {}
        options[:with_publisher] = with_publisher

        self.class.get_renderer_class.new(to_h(deep: false)).render(**options)
      end

      class << self
        def transform_supplements(supplements_params, base_params)
          supplements = supplements_params.map do |supplement|
            Identifier.create(number: supplement[:number], year: supplement[:year],
                              type: :amd, base: Identifier.create(**base_params))
          end

          return supplements.first if supplements.count == 1

          raise Errors::SupplementParsingError, "more than one or none supplements provided"
        end

        def transform_explanation(params, base_params)
          Identifier.create(type: :explanation, base: Identifier.create(**base_params), **params)
        end

        # Use Identifier#create to resolve identifier's type class
        def transform(params)
          identifier_params = params.map do |k, v|
            get_transformer_class.new.apply(k => v)
          end.inject({}, :merge)

          if identifier_params[:supplements]
            return transform_supplements(
              identifier_params[:supplements],
              identifier_params.dup.tap { |h| h.delete(:supplements) }
            )
          end

          if identifier_params[:explanation]
            return transform_explanation(
              identifier_params[:explanation].is_a?(Hash) ? identifier_params[:explanation] : {},
              identifier_params.dup.tap { |h| h.delete(:explanation) }
            )
          end

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
