require 'faraday'
require 'nokogiri'

resp = Faraday.get("https://www.99ten.ca/events")
html = resp.body

events   = []
base_url = "https://www.99ten.ca"
dom      = Nokogiri::HTML(html)
dom.css(".eventlist-event").each {
    |event| events << {
        "url"    => base_url + event.css(".eventlist-title-link").attr("href").text,
        "artist" => event.css(".eventlist-title a").text,
        "date"   => event.css(".event-date").attr("datetime").text,
        "time"   => event.css(".event-time-12hr").first.text,
        "image"  => event.css(".eventlist-column-thumbnail img").attr("data-src").text,
    }
}

