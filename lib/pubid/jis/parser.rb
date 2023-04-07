module Pubid::Jis
  class Parser < Pubid::Core::Parser

    rule(:type) do
      str("/").maybe >>
        array_to_str(Identifier.config.types.map { |type| type.type[:short] }.compact).as(:type)
    end

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

    rule(:all_parts) do
      (str("(規格群)") | str("（規格群）")).as(:all_parts)
    end

    rule(:language) do
      str("(") >> match("[A-Z]").as(:language) >> str(")")
    end

    rule(:amendment) do
      (str("/") >> (str("AMD") | str("AMENDMENT")).as(:type) >> space >> digits.as(:number) >> colon >> year).repeat(1).as(:supplements)
    end

    rule(:explanation) do
      (str("/") >> (str("EXPLANATION") | str("EXPL")) >> (space >> digits.as(:number)).maybe).as(:explanation)
    end

    rule(:identifier) do
      str("JIS").maybe >> space? >> type.maybe >> space? >> series >> space? >> digits.as(:number) >> part >>
        (colon >> year).maybe >> language.maybe >> all_parts.maybe >> amendment.maybe >> explanation.maybe
    end

    rule(:root) { identifier }
  end
end
