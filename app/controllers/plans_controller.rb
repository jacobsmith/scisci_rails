class PlansController < ApplicationController
  def view_plans
  end

  def change_plan
    if current_user.has_paid_plan?
      if params[:new_plan] != "1_active_project"
        stripe_customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
        active_subscription_id = stripe_customer["subscriptions"]["data"].first.try(:[], "id")

        subscription = Stripe::Subscription.retrieve(active_subscription_id)
        subscription.plan = params[:new_plan]
        subscription_response = subscription.save

        current_user.current_plan = params[:new_plan]
        current_user.save

        confirmed_plan = subscription_response["plan"]["name"]

        redirect_to projects_path, notice: "Thanks! Your current plan allows for #{confirmed_plan}."
      else # switching to free plan
        stripe_customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
        active_subscription_id = stripe_customer["subscriptions"]["data"].first.try(:[], "id")

        subscription = Stripe::Subscription.retrieve(active_subscription_id)
        subscription.delete(at_period_end: true)

        confirmed_plan = "1 Active Project"

        redirect_to projects_path, notice: "Thanks! Your current plan allows for #{confirmed_plan}."
      end
    elsif params[:new_plan] != "1_active_project" # no paid plan, but choosing a paid plan
      create_customer(user: current_user, stripe_email: params[:stripeEmail], stripe_token: params[:stripeToken])
      subscription_response = create_subscription(plan: params[:new_plan], user: current_user)
      update_user_plan(user: current_user, plan: subscription_response["plan"]["id"])

      confirmed_plan = subscription_response["plan"]["name"]
      redirect_to projects_path, notice: "Thanks! Your current plan allows for #{confirmed_plan}."
    else # catch all, force 1 active project
      current_user.current_plan = "1_active_project"
      confirmed_plan = "1 active project"
      redirect_to projects_path, notice: "Thanks! Your current plan allows for #{confirmed_plan}."
    end
  end

  private

  def create_customer(user:, stripe_email:, stripe_token:)
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    stripe_customer_id = customer["id"]
    user.stripe_customer_id = stripe_customer_id
    user.save!
  end

  def create_subscription(plan:, user:)
    response = Stripe::Subscription.create(
      :customer => current_user.stripe_customer_id,
      :plan => plan,
    )
  end

  def update_user_plan(user:, plan:)
    user.current_plan = plan
    user.save!
  end
end
