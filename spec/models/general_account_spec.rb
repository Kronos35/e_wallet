require 'rails_helper'

describe GeneralAccount do
  context "when new" do
    subject { described_class.new().balance }
    it("has a balance = 0") { is_expected.to eq 0 }
  end
end
