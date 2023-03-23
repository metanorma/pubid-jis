module Pubid::Jis
  RSpec.describe Identifier do
    describe "creating new identifier" do
      subject { described_class.create(**{ number: number }.merge(params)) }
      let(:number) { 123 }
      let(:params) { {} }

      it "renders default publisher" do
        expect(subject.to_s).to eq("JIS #{number}")
      end

      context "with part and year" do
        let(:params) { { part: 1, year: 1999 } }

        it "renders identifier with part and year" do
          expect(subject.to_s).to eq("JIS #{number}-1:1999")
        end

        context "with subpart" do
          let(:params) { { part: "1-2", year: 1999 } }

          it "renders identifier with part and year" do
            expect(subject.to_s).to eq("JIS #{number}-1-2:1999")
          end
        end
      end

      context "with series" do
        let(:params) { { series: "A" } }

        it "renders identifier with series" do
          expect(subject.to_s).to eq("JIS A #{number}")
        end
      end

      context "with language" do
        let(:params) { { language: "E" } }

        it "renders identifier with language" do
          expect(subject.to_s).to eq("JIS #{number}(E)")
        end
      end

      context "all parts" do
        let(:params) { { all_parts: true } }

        it "renders identifier with all-parts" do
          expect(subject.to_s).to eq("JIS #{number}（規格群）")
        end
      end
    end
  end
end
