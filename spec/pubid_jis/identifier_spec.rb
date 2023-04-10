module Pubid::Jis
  RSpec.describe Identifier do
    subject { described_class.parse(original || pubid) }
    let(:original) { nil }

    context "JIS B 0001" do
      let(:pubid) { "JIS B 0001" }
      let(:pubid_without_publisher) { "B 0001" }

      it_behaves_like "converts pubid to pubid"
      it_behaves_like "converts pubid to pubid without publisher"
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

    context "JIS C 0617(規格群)" do
      let(:pubid) { "JIS C 0617（規格群）" }

      it_behaves_like "converts pubid to pubid"

      it "has all-parts attribute" do
        expect(subject.all_parts?).to be_truthy
      end

      context "when compare with identifier with part" do
        let(:another_pubid) { "JIS C 0617-2" }

        it "returns true" do
          expect(subject == described_class.parse(another_pubid)).to be_truthy
        end
      end

      context "when compare with identifier with another year" do
        let(:another_pubid) { "JIS C 0617-2:2017" }

        it "returns true" do
          expect(subject == described_class.parse(another_pubid)).to be_truthy
        end
      end

      context "when compare with another identifier" do
        let(:another_pubid) { "JIS C 0618-1" }

        it "returns false" do
          expect(subject == described_class.parse(another_pubid)).to be_falsey
        end
      end
    end

    context "JIS B 0060（規格群）" do
      let(:pubid) { "JIS B 0060（規格群）" }

      it_behaves_like "converts pubid to pubid"
    end

    context "identifiers without whitespace" do
      context "JISX0902-1:2019" do
        let(:original) { "JISX0902-1:2019" }
        let(:pubid) { "JIS X 0902-1:2019" }

        it_behaves_like "converts pubid to pubid"
      end

      context "JISX0836:2005" do
        let(:original) { "JISX0836:2005" }
        let(:pubid) { "JIS X 0836:2005" }

        it_behaves_like "converts pubid to pubid"
      end
    end

    context "JIS TR Z 8301:2019" do
      let(:pubid) { "JIS TR Z 8301:2019" }

      it_behaves_like "converts pubid to pubid"
    end

    context "JIS TS Z 8301:2019" do
      let(:pubid) { "JIS TS Z 8301:2019" }

      it_behaves_like "converts pubid to pubid"
    end

    context "amendments" do
      context "JIS A 0001:1999/AMD 1:2000" do
        let(:pubid) { "JIS A 0001:1999/AMD 1:2000" }
        let(:pubid_without_publisher) { "A 0001:1999/AMD 1:2000" }

        it_behaves_like "converts pubid to pubid"
        it_behaves_like "converts pubid to pubid without publisher"
      end

      context "JIS X 0208:1997/AMENDMENT 1:2012" do
        let(:original) { "JIS X 0208:1997/AMENDMENT 1:2012" }
        let(:pubid) { "JIS X 0208:1997/AMD 1:2012" }

        it_behaves_like "converts pubid to pubid"
      end
    end

    context "JIS/TR X 0005:1998" do
      let(:original) { "JIS/TR X 0005:1998" }
      let(:pubid) { "JIS TR X 0005:1998" }

      it_behaves_like "converts pubid to pubid"
    end

    context "TR B 0035:2019" do
      let(:original) { "TR B 0035:2019" }
      let(:pubid) { "JIS TR B 0035:2019" }

      it_behaves_like "converts pubid to pubid"
    end

    context "TS Z0030-1:2017" do
      let(:original) { "TS Z0030-1:2017" }
      let(:pubid) { "JIS TS Z 0030-1:2017" }

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

    context "explanation" do
      context "JIS K 2151:2004/EXPL" do
        let(:pubid) { "JIS K 2151:2004/EXPL" }

        it_behaves_like "converts pubid to pubid"
      end

      context "JIS K 2249-4:2011/EXPLANATION 4" do
        let(:original) { "JIS K 2249-4:2011/EXPLANATION 4" }
        let(:pubid) { "JIS K 2249-4:2011/EXPL 4" }

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
