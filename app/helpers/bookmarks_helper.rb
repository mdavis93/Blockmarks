module BookmarksHelper

  def format_link(url)
    url = url.split(".")

    if url[0].include?("http") || url[0].include?("www")
      url.shift
    end

    url.join(".")
  end
end
