require "koala"
require "YAML"
require "time"
require "pry"

task :pull_facebook_events do
  Koala.config.api_version = "v2.8"
  client = Koala::Facebook::API.new("EAAR9le4ELiwBALiAxNpGyQjhdEgWPmGi8Bm6fbKudJXmcg1DAVoBMjMHJFWUCzdWFm2i8rB5JNNelB83rpsEbZA862SEaL4vfpsTSERcbzDIpbxGvKAh1rEJdkwOSJKM0C6cSF15GR5Hd68IHReZBLIkGyI5Tho3UfnSrjBBpw4ZCUfmiO9XnQRp21LPpQZD")
  page = client.get_object("swinginlodz")
  events = client.get_connection("swinginlodz", "events", { fields: %w(id name start_time end_time place description cover.type(large)) })
  yaml_parties = []
  events = events.sort_by do |event|
    Time.parse(event["start_time"]) rescue Time.now
  end
  events.each do |event|
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
  File.open('data/pl/parties.yml', 'w') do |out|
    YAML.dump({ parties: yaml_parties }, out)
  end
  File.open('data/en/parties.yml', 'w') do |out|
    YAML.dump({ parties: yaml_parties }, out)
  end
end

task default: [:pull_facebook_events]
