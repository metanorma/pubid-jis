module Pubid::Jis
  module Identifier
    RSpec.describe Base do
      describe "#transform_supplements" do
        subject { described_class.transform_supplements(supplements, base_params) }
        let(:base_params) do
          { publisher: "JIS",
            number: "1",
            year: "2016",
          }
        end
        let(:supplements) do
          [{ type: "AMD", number: "2", year: "1999" }]
        end

        it "returns supplement as main identifier" do
          expect(subject.number).to eq("2")
          expect(subject.type[:key]).to eq(:amd)
        end

        it "assigns base identifier to supplement" do
          expect(subject.base).to eq(Identifier.create(number: "1", year: 2016))
        end
      end
    end
  end
end
