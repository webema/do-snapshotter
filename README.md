# do-snapshotter

do-snapshotter is a small tool to add the function of automatic snapshots to DigitalOcean.
Currently it is tailored towards the kubernetes services and the volumes created by PrivateVolumeClaims.

It will create snapshots for *all* your volumes created by kubernetes.
By default those snapshots will be deleted after 7 days.

https://hub.docker.com/r/dtrierweiler/do-snapshotter

## Usage

First configure a k8s-secret with the key `access-token` and create a token at https://cloud.digitalocean.com/account/api/tokens
Then just execute `kubectl apply -f deploy/` and you're all set.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/webemsz/do-snapshotter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
