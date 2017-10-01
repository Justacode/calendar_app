class Event < ApplicationRecord
	belongs_to :user

	validates :name, presence: true, length: {minimum: 5, maximum: 128}
	validates :frequency, inclusion: { in: %w(once dayly weekly monthly yearly)}
	validates :start_date, presence: true

	def self.by_range (start_date, finish_date)
		self.where("(finish_date >= ? AND start_date <= ?) 
			OR (start_date <= ? AND finish_date IS ?)", start_date, finish_date, finish_date, nil).to_a
	end

end
