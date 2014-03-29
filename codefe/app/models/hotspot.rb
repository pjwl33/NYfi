class Hotspot < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :users

  validates :name, :address, :hood, :biz_url, :type, :noise_level, presence: true
  validates :power, :status, inclusion: { in: [true, false] }
  validates :dl_speed, :ul_speed, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :yelp_rating, numericality: { greater_than_or_equal_to: 0 }

  def self.search_yelp(query)
    consumer_key = '236ie4UyRnPA5umbGdZ1-Q'
    consumer_secret = '3eH9lvl2lHs7XgCZA4c96o3wutI'
    token = 'j7LlwpapqLWwyjAk4axFVgQsL7XZFpEP'
    token_secret = 'eK0AxjiVOzNIvEYSdr8dOzzkdE4'

    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, { site: "http://#{api_host}"})
    access_token = OAuth::AccessToken.new(consumer, token, token_secret)

    path = "/v2/search?term=restaurants&location=new%20york"

    access_token.get(path).body

  end


end