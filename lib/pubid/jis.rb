# frozen_string_literal: true

require "parslet"

module Pubid
end

require "pubid-core"

require_relative "jis/errors"
require_relative "jis/identifier/base"
require_relative "jis/identifier/technical_report"
require_relative "jis/identifier/technical_specification"
require_relative "jis/identifier/amendment"
require_relative "jis/identifier/explanation"
require_relative "jis/renderer/base"
require_relative "jis/renderer/technical_report"
require_relative "jis/renderer/technical_specification"
require_relative "jis/renderer/amendment"
require_relative "jis/renderer/explanation"
require_relative "jis/parser"
require_relative "jis/identifier"

config = Pubid::Core::Configuration.new
config.default_type = Pubid::Jis::Identifier::Base
config.types = [Pubid::Jis::Identifier::Base,
                Pubid::Jis::Identifier::TechnicalReport,
                Pubid::Jis::Identifier::TechnicalSpecification,
                Pubid::Jis::Identifier::Amendment,
                Pubid::Jis::Identifier::Explanation]
config.type_names = {}.freeze
Pubid::Jis::Identifier.set_config(config)
