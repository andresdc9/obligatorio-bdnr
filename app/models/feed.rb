class Feed
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message, type: String

  validates :message,  presence: true

  def save_cache
    feed = Feed.order('created_at DESC')
    Rails.cache.write("actions_feed", feed)
  end
end
