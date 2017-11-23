require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ChargesHelper. For example:
#
# describe ChargesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ChargesHelper, type: :helper do

  describe "getChargeAmountInDollars" do
    it "should return default value as cents" do
      cents = getChargeAmountInDollars
      expect(cents).to eq(1500)
    end

    it "should convert provided whole dollar to cents" do
      cents = getChargeAmountInDollars(20)
      expect(cents).to eq(2000)
    end

    it "should convert dollars and cents to cents" do
      cents = getChargeAmountInDollars(49.99)
      expect(cents).to eq(4999)
    end
  end

end
