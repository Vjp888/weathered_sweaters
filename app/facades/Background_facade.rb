class BackgroundFacade
  attr_reader :id

  def initialize(loc)
    @id = 1
    @location = loc
  end

  def get_background
    @_background ||= FlickrService.new.get_image(@location)
  end

  def background
    json = get_background[:photos][:photo].first
    "https://farm#{json[:farm]}.staticflickr.com/#{json[:server]}/#{json[:id]}_#{json[:secret]}.jpg"
  end
end
