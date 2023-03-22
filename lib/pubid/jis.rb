# frozen_string_literal: true

require "parslet"

module Pubid
end

require "pubid-core"

require_relative "jis/errors"
require_relative "jis/identifier/base"
require_relative "jis/renderer/base"
require_relative "jis/parser"
require_relative "jis/identifier"

config = Pubid::Core::Configuration.new
config.default_type = Pubid::Jis::Identifier::Base
config.types = [Pubid::Jis::Identifier::Base]
config.type_names = {}.freeze
Pubid::Jis::Identifier.set_config(config)
