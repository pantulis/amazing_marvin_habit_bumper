require 'json'
require 'date'
require './lib/marvin/api/http.rb'

module MarvinAPI
  
  # habit is a str
  def MarvinAPI.get_habit(habit_id)
    request_body = '{ "selector": { "db": "Habits", "_id": { "$eq" : "' + habit_id + '" }}}'
    json = MarvinHTTPApi.new.post("_find", request_body)
  end
  
  def MarvinAPI.bump_habit(habit_id)

    request_body = '{ "selector": { "db": "Habits", "_id": { "$eq" : "' + habit_id + '" }}}'

    json =  MarvinHTTPApi.new.post("_find", request_body)
    payload = JSON.parse(json)

    item = payload["docs"].first
    history = item["history"]
    title = item["title"]
    
    # marvin timestamps are in ms
    now_timestamp = Time.now.to_i * 1000

    history << now_timestamp
    history << 1

    new_payload = payload
    new_payload["docs"].first["history"] = history
    new_payload["docs"].first["fieldUpdates"]["history"] = now_timestamp
    new_payload["docs"].first["updatedAt"] = now_timestamp

    body_hash = new_payload["docs"].first.to_json
    json = MarvinHTTPApi.new.put(habit_id, body_hash)
    
    return json
  end
  
end