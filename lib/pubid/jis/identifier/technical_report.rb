require_relative "../renderer/technical_report"

module Pubid::Jis
  module Identifier
    class TechnicalReport < Base
      def_delegators 'Pubid::Jis::Identifier::TechnicalReport', :type

      def self.type
        { key: :tr, title: "Technical Report", short: "TR" }
      end

      def self.get_renderer_class
        Renderer::TechnicalReport
      end
    end
  end
end
