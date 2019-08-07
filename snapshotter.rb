require 'droplet_kit'

unless ENV.key?("DIGITALOCEAN_TOKEN")
  raise ArgumentError.new("Please set the env variable DIGITALOCEAN_TOKEN.")
end

client = DropletKit::Client.new(access_token: ENV.fetch("DIGITALOCEAN_TOKEN"))

# Create snapshots for all volumes
client.volumes.all.each do |volume|
  client.volumes.create_snapshot(id: volume.id, name: "#{volume.name}-#{Date.today}")
  puts "Snapshot created for #{volume.name}"
end

# cleanup snapshots and keep only the last week
client.snapshots.all(resource_type: "volume").each do |snapshot|
  if Date.parse(snapshot.created_at) < Date.today - 7.days
    client.snapshots.delete(id: snapshot.id)
    puts "Snapshot #{snapshot.name} deleted"
  end
end
