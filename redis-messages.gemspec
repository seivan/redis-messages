# -*- encoding: utf-8 -*-
VERSION = "0.1"

Gem::Specification.new do |s|
  s.name        = "redis-messages"
  s.version     = VERSION
  s.author      = "Seivan Heidari"
  s.email       = "seivan@kth.se"
  s.homepage    = "http://github.com/seivan/redis-messages"
  s.summary     = "A messaging library with outbox/inbox system utilizing the power of both Redis and SQL"
  s.description = "A messaging library with outbox/inbox system utilizing the power of both Redis and SQL. Using SQL for the outbox with user_id FK's and Redis for the inbox. A message has one sender, multiple recievers"

  s.files        = Dir["{lib,test,features}/**/*", "[A-Z]*"]
  s.require_path = "lib"

  s.add_development_dependency 'rspec-rails', '~> 2.0.1'
  s.add_development_dependency 'cucumber', '~> 0.9.2'
  s.add_development_dependency 'rails', '~> 3.0.0'
  s.add_development_dependency 'mocha', '~> 0.9.8'
  s.add_development_dependency 'bcrypt-ruby', '~> 2.1.2'
  s.add_development_dependency 'sqlite3-ruby', '~> 1.3.1'

  s.rubyforge_project = s.name
  s.required_rubygems_version = ">= 1.3.4"
end
