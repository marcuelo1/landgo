class Admin::VouchersController < AdministratorController
    include ApplicationHelper

    def index
        @vouchers = Voucher.all
    end

    def new
        @voucher = Voucher.new()
    end

    def create
        @voucher = Voucher.new(voucher_params)
        @voucher.status = 0
        @voucher.valid_from = date_form_format(params[:valid_from])
        @voucher.valid_until = date_form_format(params[:valid_until])
        
        if @voucher.save 
            redirect_to "/admin/vouchers"
        else

        end
    end

    def edit
        @voucher = Voucher.find(params[:id])
    end

    def update
        @voucher = Voucher.find(params[:id])
        @voucher.update(voucher_params)
        @voucher.status = params[:voucher][:status].to_i
        @voucher.valid_from = date_form_format(params[:valid_from])
        @voucher.valid_until = date_form_format(params[:valid_until])
        
        if @voucher.save 
            redirect_to "/admin/vouchers"
        else

        end
    end

    private
    def voucher_params
        params.require(:voucher).permit(:code, :description, :discount, :discount_type, :min_amount, :max_discount)        
    end
end
