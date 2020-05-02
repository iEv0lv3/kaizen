class KaizenApiService
  attr_reader :uid

  def initialize(user)
    @uid = user.so_uid
    @username = user.gh_login
  end

  def find_awards
    response = connection('so_badges').get
    response.body
  end

  private

  def connection(url)
    Faraday.new("https://mighty-basin-93040.herokuapp.com/#{url}") do |f|
      f.headers['User_id'] = @uid
      f.headers['Username'] = @username
    end
  end
end
