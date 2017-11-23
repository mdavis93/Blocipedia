module ChargesHelper
  def getChargeAmountInDollars(dollars = 15)
    cents = (dollars.floor * 100) + ((dollars - dollars.floor) * 100)

    cents
  end
end
