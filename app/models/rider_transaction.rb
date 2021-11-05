class RiderTransaction < ApplicationRecord
  belongs_to :rider
  belongs_to :checkout_seller

  enum status: {"Decline" => 0, "On Deliver" => 1, "Cancelled" => 2, "Completed" => 3}
  after_create :update_rider_acceptance_rate

  def update_rider_acceptance_rate
    rider = self.rider 
    # get acceptance_rate
    total = rider.rider_transactions.count 
    accepted = rider.rider_transactions.where.not(status: "Decline").count

    acceptance_rate = (accepted.to_f / total.to_f) * 100
    batch1 = Batch.find_by(name: "Batch 1")
    batch2 = Batch.find_by(name: "Batch 2")
    batch3 = Batch.find_by(name: "Batch 3")
    batch4 = Batch.find_by(name: "Batch 4")

    if acceptance_rate >= batch1.acceptance_rate
      batch_id = batch1.id
    elsif acceptance_rate >= batch2.acceptance_rate
      batch_id = batch2.id
    elsif acceptance_rate >= batch3.acceptance_rate
      batch_id = batch3.id
    else
      batch_id = batch4.id
    end

    rider.update(acceptance_rate: acceptance_rate, batch_id: batch_id)
    rider.reload
  end
end
