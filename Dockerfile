FROM ruby:2.6-alpine3.10

RUN gem install droplet_kit

COPY snapshotter.rb /

CMD ["ruby", "snapshotter.rb"]
