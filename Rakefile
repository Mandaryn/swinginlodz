require "koala"
require "YAML"
require "pry"

task :pull_facebook_events do
  Koala.config.api_version = "v2.8"
  client = Koala::Facebook::API.new("EAACEdEose0cBAOVbSVLcuxZAzQAUZB23lhEfr5hQwdlbRaAJhjvfI6TWdUO0PrgCkFAKbz6AMfZBMzm4k4NZCIzDSxSjXPY1doAShadutqjNME2rlMIepQu8Cre2B3S8ZBjCyLZAODxhO5vKk2MrgLAek69xJTvDKqAF8XI3xM3RcER4zrFGKcsRTYoq5G1BQZD")
  page = client.get_object("swinginlodz")
  events = client.get_connection("swinginlodz", "events", { fields: %w(id name start_time end_time place description picture.type(large)) })
  yaml_parties = []
  events.each do |event|
    yaml_parties << {
      url: "https://developers.facebook.com/#{event['id']}",
      name: event["name"],
      start: event["start_time"],
      end: event["end_time"],
      venue: [event["place"]&.[]("name"),event["place"]&.[]("location")&.[]("street")].compact.join(", "),
      photo: event["picture"]&.[]("data")&.[]("url"),
      description: event["description"]
    }
  end
  File.open('data/pl/parties.yml', 'w') do |out|
    YAML.dump({ parties: yaml_parties }, out)
  end
  File.open('data/en/parties.yml', 'w') do |out|
    YAML.dump({ parties: yaml_parties }, out)
  end
end
