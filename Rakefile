require "koala"
require "YAML"
require "time"
require "pry"

task :pull_facebook_events do
  Koala.config.api_version = "v2.8"
  client = Koala::Facebook::API.new("EAACEdEose0cBAPvi9yNg6Ik1ZA97kAsPetpEyPnu7YHivTK7rDh7yKZBTDpr7Hq1NxZBWJT0L4YBpJVoTETVrONV0cr5XkKHch7y5uSzFBxKlVEAk12FMlw0iJLVfWwyeczBhrFHD8qeMq45xWPmzb40tyXJcGzQ4TbZCxXj6inUUNNEN7TymT5ZCo6CaUU26S3dUYSXfqwZDZD")
  page = client.get_object("swinginlodz")
  events = client.get_connection("swinginlodz", "events", { fields: %w(id name start_time end_time event_times place description cover.type(large)) })
  yaml_parties = []
  events = events.sort_by do |event|
    Time.parse(event["start_time"]) rescue Time.now
  end
  events.each do |event|
    if event["event_times"]
      event["event_times"].each do |event_times|
        yaml_parties << {
          url: "https://www.facebook.com/#{event_times['id']}",
          name: event["name"],
          start: event_times["start_time"],
          end: event_times["end_time"],
          venue: [event["place"]&.[]("name"),event["place"]&.[]("location")&.[]("street")].compact.join(", "),
          photo: event["cover"]&.[]("source"),
          description: event["description"]
        }
      end
    else
      yaml_parties << {
        url: "https://www.facebook.com/#{event['id']}",
        name: event["name"],
        start: event["start_time"],
        end: event["end_time"],
        venue: [event["place"]&.[]("name"),event["place"]&.[]("location")&.[]("street")].compact.join(", "),
        photo: event["cover"]&.[]("source"),
        description: event["description"]
      }
    end
  end
  File.open('data/pl/parties.yml', 'w') do |out|
    YAML.dump({ parties: yaml_parties }, out)
  end
  File.open('data/en/parties.yml', 'w') do |out|
    YAML.dump({ parties: yaml_parties }, out)
  end
end

task default: [:pull_facebook_events]
