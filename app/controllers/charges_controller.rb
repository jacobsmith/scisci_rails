class ChargesController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # Amount in cents
    @yearly_amount = 1000
    @monthly_amount = 200
    
#    @params=params
#    pry

    customer = Stripe::Customer.create(
      :email => params[:email],
      :card => params[:stripeToken],
      :plan => params[:plan],
      :coupon => params[:coupon]
    )

    ## Ensure plan and payment match up (to stop people like me from curl-ing weird data)
    if params[:plan] == 'yearly_plan'
      @amount = @yearly_amount
    elsif params[:plan] == 'monthly_plan'
      @amount = @monthly_amount
    else
      flash[:error] = "That is not a valid plan. Please try again."
      redirect_to charges_path
    end

    charge = Stripe::Charge.create(
      :customer   => customer.id,
      :amount     => ( params[:plan] == 'yearly_plan' ? @yearly_amount : @monthly_amount ),
      :description => 'Cite & Write Notes Subscription',
      :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

end
