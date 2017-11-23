class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: getChargeAmountInDollars
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    current_user.stripe_id = customer.id

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       getChargeAmountInDollars,
      description:  "BigMoney Membership - #{current_user.email}",
      currency:     'usd'
    )

    flash[:notice] = "Account successfully upgraded, you are now a PREMIUM Member!"
    current_user.role = :premium
    current_user.save!

    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    if customer.delete
      flash[:notice] = "\"#{current_user.email}\" was downgraded to standard successfully.\nAll associated Wiki's have been marked as PUBLIC."
      current_user.role = 'standard'
      current_user.save!

      wikis = current_user.wikis
      wikis.each do |wiki|
        if wiki.private
          wiki.private = false
          wiki.save!
        end
      end

      redirect_to new_charge_path
    else
      flash.now[:alert] = "There was an error downgrading the user."
      redirect_to new_charge_path
    end
  end
end
