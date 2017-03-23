require "koala"
require "YAML"
require "pry"

task :pull_facebook_events do
  Koala.config.api_version = "v2.8"
  client = Koala::Facebook::API.new("EAACEdEose0cBAKJHClMKZB2FGuKyWQQNrZB2btAFlZCWoE2rQAZBHv2Agx8ZAJ3NScqX5UXvVczw9UaCJgZAiAtvhbb0D3WVbmuZA89Q7nfNCzDulG7Rz8sSivbPtgXAj5Yq6cBw7Q28Tc1b5l5TFePzZBDb72hL5MYVSOuZAoIXNZC9dpxvZAjQhhh")
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
end
