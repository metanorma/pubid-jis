shared_examples "converts pubid to pubid" do
  it "converts pubid to pubid" do
    expect(subject.to_s).to eq(pubid)
  end
end
