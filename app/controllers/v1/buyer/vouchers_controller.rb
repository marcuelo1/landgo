class V1::Buyer::VouchersController < BuyerController
    def index
        vouchers = @buyer.vouchers

        render json: {vouchers: VoucherBlueprint.render(vouchers)}, status: 200
    end
end
