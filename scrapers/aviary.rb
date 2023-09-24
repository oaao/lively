require 'faraday'
require 'nokogiri'

resp = Faraday.get("https://www.the-aviary.net/events")
html = resp.body

events   = []
base_url = "https://www.the-aviary.net"
dom      = Nokogiri::HTML(html)
dom.css(".eventlist-event").each {
    |event| events << {
        "url"    => base_url + event.css(".eventlist-title-link").attr("href").text,
        "artist" => event.css(".eventlist-title-link").text.gsub(
            /@ The Aviary|At The Aviary|@ The Avairy|At The Avairy/, ""
        ).rstrip.gsub(/!$/, ""),
        "date"   => event.css(".event-date").attr("datetime").text,
        "time"   => event.css(".event-time-12hr-start").text,
        "image"  => event.css(".eventlist-column-thumbnail img").attr("data-src").text,
    }
}

