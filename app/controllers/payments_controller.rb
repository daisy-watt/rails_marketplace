class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def success
      @order = Order.find_by(listing_id: params[:id])
    end

    def create_checkout_session
        @listing = Listing.find(params[:id])

        session = Stripe::Checkout::Session.create(
            payment_method_types: ["card"],
            customer_email:current_user && current_user.email,
            line_items: [
              {
                name: @listing.title,
                description: @listing.description,
                amount: @listing.price,
                currency: "aud",
                quantity: 1
              }
            ],
            payment_intent_data: {
              metadata: {
                user_id: current_user && current_user.id,
                listing_id: @listing.id
              }
            },
            success_url: "#{root_url}payments/success/#{@listing.id}",
            cancel_url: root_url
          )
      
          @session_id = session.id
    end

    def webhook

        begin 
            payload = request.raw_post
            header = request.headers['HTTP_STRIPE_SIGNATURE']
            secret = Rails.application.credentials.dig(:stripe,:webhook_signing_secret) 
            event = Stripe::Webhook.construct_event(payload, header, secret)
        rescue Stripe::SignatureVerificationError => e
            render json: {error: "Unauthorised"}, status: 403
            return
        rescue JSON::ParserError => e
            render json: {error: "Bad request"}, status: 422
            return
        end

        #tracking out purchase info

        payment_intent_id = event.data.object.payment_intent
        payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
        listing_id = payment.metadata.listing_id
        buyer_id = payment.metadata.user_id
        pp payment.charges.data[0].receipt_url
        @listing = Listing.find(listing_id)
        @listing.update(sold: true)

        #create order/purchase and track info
        Order.create(listing_id: listing_id, buyer_id: buyer_id, seller_id: @listing.user_id, payment_id: payment_intent_id, receipt_url: payment.charges.data[0].receipt_url )
    end
end