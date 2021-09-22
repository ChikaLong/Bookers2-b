class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200}

  scope :created_today, -> {where(created_at: Time.zone.now.all_day)}
  scope :created_yesterday, -> {where(created_at: Time.zone.yesterday.all_day)}
  scope :created_week, -> {where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
  scope :created_lastweek, -> {where(created_at: 13.day.ago.beginning_of_day...7.day.ago.end_of_day)}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
