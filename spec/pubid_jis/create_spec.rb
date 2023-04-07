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

      context "technical report" do
        let(:params) { { type: :tr } }

        it "renders technical report identifier" do
          expect(subject.to_s).to eq("JIS TR #{number}")
        end
      end

      context "technical specification" do
        let(:params) { { type: :ts } }

        it "renders technical specification identifier" do
          expect(subject.to_s).to eq("JIS TS #{number}")
        end
      end

      context "amendment" do
        let(:params) { { type: :amd, base: described_class.create(number: number), number: 1, year: 1999 } }

        it "renders amendment to base identifier" do
          expect(subject.to_s).to eq("JIS #{number}/AMD 1:1999")
        end
      end

      context "explanation" do
        let(:params) { { type: :explanation, base: described_class.create(number: number), number: 1 } }

        it "renders explanation to base identifier" do
          expect(subject.to_s).to eq("JIS #{number}/EXPL 1")
        end
      end
    end
  end
end
