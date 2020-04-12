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
    Faraday.new("https://quiet-harbor-86448.herokuapp.com/#{url}") do |f|
      f.headers['UID'] = @uid
      f.headers['USERNAME'] = @username
    end
  end
end
