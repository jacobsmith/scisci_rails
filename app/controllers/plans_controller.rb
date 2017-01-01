class PlansController < ApplicationController
  def view_plans
  end

  def change_plan
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    stripe_customer_id = customer["id"]
    current_user.stripe_customer_id = stripe_customer_id
    current_user.save!

    new_plan = params[:new_plan]

    response = Stripe::Subscription.create(
      :customer => current_user.stripe_customer_id,
      :plan => new_plan,
    )

    current_user.current_plan = new_plan
    current_user.save!

    confirmed_plan = response["plan"]["name"]
    redirect_to projects_path, notice: "Thanks! Your current plan allows for #{confirmed_plan}."
  end
end
