require "koala"
require "YAML"
require "time"
require "pry"

task :pull_facebook_events do
  Koala.config.api_version = "v2.8"
  client = Koala::Facebook::API.new("EAACEdEose0cBAHC6DlZAe1IaYn5HRCA15eNZBiJkrkgReFnTN2owOPfVkUuGMq4mbadVsZCPd9IOVc7BlVnRZBLdbMZADJZBUbARw7xUtTCIcF21DftRdx63aEYw6lchqMXP3rZB3jsYUg1EGUnCJqy86FIGXTtZAQQEpcMB7O1MJtHDeTqr2S74UbhrtjjZAcLgZD")
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
