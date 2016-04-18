class Message < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy

  SEARCH_QUERY = <<-QUERY
    users.full_name LIKE ?
    OR title LIKE ?
    OR description LIKE ?
  QUERY

  def self.search(filter)
    joins(:user).
    where(SEARCH_QUERY, "%#{filter}%", "%#{filter}%", "%#{filter}%")
  end
end
