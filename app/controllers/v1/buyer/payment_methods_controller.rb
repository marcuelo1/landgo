class V1::Buyer::PaymentMethodsController < BuyerController
    def select_payment_method
        payment_method = @buyer.buyer_payment_methods.where(payment_method_id: params[:id]).first 

        if payment_method.nil?
            payment_method = BuyerPaymentMethod.create(buyer: @buyer, payment_method_id: params[:id])
        end

        @buyer.buyer_payment_methods.update(selected: false)
        payment_method.update(selected: true)

        render json: {success: true}, status: 200
    end
end
