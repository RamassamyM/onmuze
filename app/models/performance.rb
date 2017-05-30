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
  validates :youtube_url, format: { with: /\A((https:\/\/www\.youtube\.com\/watch\?v=)|(https:\/\/youtu\.be\/)|(\<iframe width\=\"\d+\" height\=\"\d+\" src\=\"https:\/\/www\.youtube\.com\/embed\/))(?<id>[^\/\?\&"]+)((\?|&|").+)?\z/,
  message: "Enter a valid Youtube url" }, allow_blank: true
  validates :soundcloud_url, format: { with: /\A(.+)(soundcloud\.com\/(tracks\/)?)(?<id>[^\&\/]+)(.+)?\z/,
  message: "Enter a valid soundclound embedded block" }, allow_blank: true
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def test_media
    errors = {}
    errors[:soundcloud] = self.generate_embedded_soundcloud == 'error' ? "Your soundcloud url is not valid." : nil
    errors[:youtube] = self.generate_embedded_youtube == 'error' ? "Your youtube url is not valid." : nil
    errors[:instagram] = self.generate_instagram == 'error' ? "Your instagram url is not valid." : nil
    errors
  end

  def generate_embedded_youtube
    begin
    return '' if self.youtube_url.empty?
    embed_url = youtube_url.match('\A((https:\/\/www\.youtube\.com\/watch\?v=)|(https:\/\/youtu\.be\/)|(\<iframe width\=\"\d+\" height\=\"\d+\" src\=\"https:\/\/www\.youtube\.com\/embed\/))(?<id>[^\/\?\&"]+)((\?|&|").+)?\z')
    return '' if embed_url.nil?
    "<iframe width='100%' height='300' src='https://www.youtube.com/embed/#{embed_url[:id]}' frameborder='0' allowfullscreen></iframe>".html_safe
    rescue
      puts "="*30
      puts "Handle missing youtube here"
      return 'error'
    end
  end

  def generate_embedded_soundcloud
    begin
    return '' if self.soundcloud_url.empty?
    # embed_url = soundcloud_url.match('/(.+)(api\.soundcloud\.com\/tracks\/)(?<id>[^\&\/]+)(.+)?/')
    # return "" if embed_url.nil?
    # "<iframe width='100%' height='300' scrolling='no' frameborder='no' src='https://w.soundcloud.com/player/?url=https\%3A//api.soundcloud.com/tracks/#{embed_url[:id]}&amp;auto_play=false&amp;hide_related=false&amp;show_comments=true&amp;show_user=true&amp;show_reposts=false&amp;visual=true'></iframe>".html_safe
    url = "https://soundcloud.com/oembed?url=" + self.soundcloud_url + "&format=json&maxheight=300"
    soundcloud_serialized = open(url).read
    JSON.parse(soundcloud_serialized)["html"].html_safe
    rescue
      puts "="*30
      puts "Handle missing soundcloud here"
      return 'error'
    end
  end

  def generate_instagram
    begin
    return '' if self.soundcloud_url.empty?
    url = "https://api.instagram.com/oembed?url=" + self.instagram_url + "&format=json&maxwidth=320&hidecaption=true"
    instagram_serialized = open(url).read
    JSON.parse(instagram_serialized)["html"].html_safe
    rescue
      puts "="*30
      puts "Handle missing instagram here"
      return 'error'
    end
  end
end
