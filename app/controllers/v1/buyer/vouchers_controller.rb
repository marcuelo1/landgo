class V1::Buyer::VouchersController < BuyerController
    def index
        vouchers = @buyer.vouchers

        render json: {vouchers: vouchers_info(vouchers)}, status: 200
    end
end
