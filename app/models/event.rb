class Event < ApplicationRecord
  searchable do
    text :name, :default_boost => 2
    text :description
  end

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  validates :name, presence: true, length: {minimum: 5, maximum: 64}
  validates :frequency, inclusion: { in: %w(once dayly weekly monthly yearly)}
  validates :start_date, presence: true
  validate :start_date_cannot_be_later_than_finish_date

  def self.by_range (start_date, finish_date)
    self.where("(start_date <= :fd AND (finish_date >= :sd OR finish_date IS NULL) AND frequency != 'yearly')
      OR (((start_date BETWEEN :sd AND :fd) OR (finish_date BETWEEN :sd AND :fd) OR finish_date IS NULL) 
      AND frequency = 'yearly')", {fd: finish_date, sd: start_date}).order(:start_date).to_a
  end

  def self.by_tag_name(tag_name)
    Tag.find_by(name: tag_name).events
  end

  def tags=(tags)
    super tags.split(",").map { |tag| Tag.find_or_create_by(name: tag.strip) } unless tags.empty?
  end

  private

  def start_date_cannot_be_later_than_finish_date
    errors.add(:start_date, "can't be later than finish date") if finish_date && finish_date < start_date
  end
end
