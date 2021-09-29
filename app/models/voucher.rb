class Voucher < ApplicationRecord
    enum status: {:Pending => 0, :Approved => 1}

    def status_int
        Voucher.statuses[self.status]
    end
end
