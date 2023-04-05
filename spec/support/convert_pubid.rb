shared_examples "converts pubid to pubid" do
  it "converts pubid to pubid" do
    expect(subject.to_s).to eq(pubid)
  end
end

shared_examples "converts pubid to pubid without publisher" do
  it "converts pubid to pubid without publisher" do
    expect(subject.to_s(with_publisher: false)).to eq(pubid_without_publisher)
  end
end
