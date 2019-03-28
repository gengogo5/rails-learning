class Task < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  # 検証用メソッドの登録
  validate :validate_name_not_including_comma

  # has_manyとの対
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  private

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
