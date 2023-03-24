require_relative "../renderer/amendment"

module Pubid::Jis
  module Identifier
    class Amendment < Base
      attr_accessor :base

      def_delegators 'Pubid::Jis::Identifier::Amendment', :type

      def initialize(base: nil, **opts)
        super(**opts)
        @base = base
      end

      def self.type
        { key: :amd, title: "Amendment", short: "AMD" }
      end

      def self.get_renderer_class
        Renderer::Amendment
      end
    end
  end
end
