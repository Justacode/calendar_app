class SearchService
  def fetch_events(query)
    search = Event.search{ keywords(query) }
    search.results
  end
end
