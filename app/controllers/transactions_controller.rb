class TransactionsController < ApplicationController

  def create
    book = Book.find_by!(slug: params[:slug])
    token = params[:stripeToken]

    begin
      # Charge the Card
      charge = Stripe::Charge.create(
          amount: book.price,
          currency: "usd",
          card: token,
          description: current_user.email
      )
      # Proceed to the Sale
      @sale = book.sales.create!(buyer_email: current_user.email)
      # Redirect user to the pickup url
      redirect_to pickup_url(guid: @sale.guid)
      # Rescue any error if it occurs
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to book_path(book)

    end

  end

  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @book = @sale.book

  end

end
