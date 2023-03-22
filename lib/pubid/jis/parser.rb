module Pubid::Jis
  class Parser < Pubid::Core::Parser
    rule(:space) do
      str(" ") | str("　")
    end

    rule(:dash) do
      str("-") | str("ｰ")
    end

    rule(:colon) do
      str(":") | str("：")
    end

    rule(:series) do
      match("[A-Z]").as(:series)
    end

    rule(:part) do
      (dash >> digits.as(:part)).repeat
    end

    rule(:language) do
      str("(") >> match("[A-Z]").as(:language) >> str(")")
    end

    rule(:identifier) do
      str("JIS") >> space >> series >> space >> digits.as(:number) >> part >> (colon >> year).maybe >> language.maybe
    end

    rule(:root) { identifier }
  end
end
