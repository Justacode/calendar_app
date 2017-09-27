class Event < ApplicationRecord
	belongs_to :user

	validates :name, presence: true, length: {minimum: 5, maximum: 128}
	validates :frequency, inclusion: { in: %w(once dayly weekly monthly yearly)}

	def self.by_range (start_date, finish_date)
		self.where.not("finish_date < ? OR start_date > ?", start_date, finish_date).to_a
	end

end
