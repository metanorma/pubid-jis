module Pubid::Jis
  RSpec.describe Identifier do
    subject { described_class.parse(original || pubid) }
    let(:original) { nil }

    context "JIS B 0001" do
      let(:pubid) { "JIS B 0001" }

      it_behaves_like "converts pubid to pubid"
    end

    context "JIS C 61000-3-2" do
      let(:pubid) { "JIS C 61000-3-2" }

      it_behaves_like "converts pubid to pubid"
    end

    context "JIS C 61000-3-2:2011" do
      let(:pubid) { "JIS C 61000-3-2:2011" }

      it_behaves_like "converts pubid to pubid"
    end

    context "JIS Z 8301:2019(J)" do
      let(:pubid) { "JIS Z 8301:2019(J)" }

      it_behaves_like "converts pubid to pubid"
    end

    context "JIS Z 8301:2019(E)" do
      let(:pubid) { "JIS Z 8301:2019(E)" }

      it_behaves_like "converts pubid to pubid"
    end

    context "japanese characters" do
      context "dash" do
        let(:original) { "JIS C 61000ｰ3ｰ2" }
        let(:pubid) { "JIS C 61000-3-2" }

        it_behaves_like "converts pubid to pubid"
      end

      context "whitespace" do
        let(:original) { "JIS　B　0001" }
        let(:pubid) { "JIS B 0001" }

        it_behaves_like "converts pubid to pubid"
      end

      context "colon" do
        let(:original) { "JIS C 61000-3-2：2011" }
        let(:pubid) { "JIS C 61000-3-2:2011" }

        it_behaves_like "converts pubid to pubid"
      end
    end

    describe "parse identifiers from examples files" do
      shared_examples "parse identifiers from file" do
        it "parse identifiers from file" do
          f = open("spec/fixtures/#{examples_file}")
          f.readlines.each do |pub_id|
            next if pub_id.match?("^#")

            pub_id = pub_id.split("#").first.strip.chomp
            expect do
              described_class.parse(pub_id)
            rescue Exception => failure
              raise Pubid::Core::Errors::ParseError,
                    "couldn't parse #{pub_id}\n#{failure.message}"
            end.not_to raise_error

            expect(described_class.parse(pub_id).to_s.upcase).to eq(pub_id.upcase)
          end
        end
      end

      context "parses identifiers from iso-pubid-basic.txt" do
        let(:examples_file) { "jis-pubids.txt" }

        it_behaves_like "parse identifiers from file"
      end
    end
  end
end
