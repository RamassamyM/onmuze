class Performance < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :proposals
  has_many :events, through: :proposals
  has_attachment :avatar
  has_attachment :banner
  validates :name, presence: true
  validates :address, presence: true
  validates :genre_id, presence: true
  validates :youtube_url, format: { with: /((.+\?v=)(.+)(&.+))|((.+\?v=)(.+))|((.+\.be\/)(.+))/,
  message: "Enter a valid Youtube url" }
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def generate_embedded_youtube
    return '' if self.youtube_url.empty?
    embed_url = youtube_url.match('((.+\?v=)(.+)(&.+))|((.+\?v=)(.+))|((.+\.be\/)(.+))')
    return "" if embed_url.nil?
    video_id = embed_url[3] || embed_url[7] || embed_url[10]
    "<iframe width='100%' height='300' src='https://www.youtube.com/embed/#{video_id}' frameborder='0' allowfullscreen></iframe>".html_safe
  end

end
