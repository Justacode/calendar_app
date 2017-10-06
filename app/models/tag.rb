class Tag < ApplicationRecord
	has_many :taggings
	has_many :events, through: :taggings
	validate :name_must_contain_only_letters_and_underscores

	private

	def name_must_contain_only_letters_and_underscores
		errors.add(:name, "must contain only letters and underscores") unless /^[[:alpha:][_][:space:]]*$/ =~ (name)
	end
end
