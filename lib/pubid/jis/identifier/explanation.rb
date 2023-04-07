require_relative "../renderer/amendment"

module Pubid::Jis
  module Identifier
    class Explanation < Base
      attr_accessor :base

      def_delegators 'Pubid::Jis::Identifier::Explanation', :type

      def initialize(base: nil, number: nil, **opts)
        super(**opts.merge(number: number))
        @base = base
      end

      def self.type
        { key: :explanation, title: "Explanation", short: "EXPL" }
      end

      def self.get_renderer_class
        Renderer::Explanation
      end
    end
  end
end
