class SearchService

  def initialize(user)
    @user = user
  end

  def fetch_events(query)
  	user = @user
    search = Event.search(query)
  end
end
