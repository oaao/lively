require 'faraday'
require 'nokogiri'

resp = Faraday.get("https://www.starliteroom.ca/calendar/")
html = resp.body

events = []
dom    = Nokogiri::HTML(html)
dom.css(".tw-cal-event").each {
    |event| events << {
        "url"    => event.css(".tw-name a").attr("href").text,
        "artist" => event.css(".tw-name a").text,
        "date"   => event.css(".tw-date-time span.tw-event-date-complete").text,
        "time"   => event.css(".tw-event-time-complete a").text,
        "image"  => event.css(".tw-image a img").attr("src").text,
    }
}

