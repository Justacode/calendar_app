class SearchService

  def initialize(user)
    @user = user
  end

  def fetch_events(query)
  	user = @user
    search = Event.search do	
      with(:user_id).equal_to(user.id)
      keywords(query)
    end
    search.results
  end
end
