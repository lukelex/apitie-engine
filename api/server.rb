require "grape"
require "rack/cors"
require_relative "../business/setup"
require_relative "./helpers"
require_rel "./resources/*.rb"

class API < ::Grape::API
  version "v1", using: :header, vendor: "restinme"
  format :json
  content_type :json, "application/json"
  prefix :api

  use ::Rack::Cors do
    allow do
      origins "*"
      resource "*",
        headers: :any,
        methods: %i( get post put delete options )
    end
  end

  helpers ::AuthHelpers

  mount ::Resources::Authentication
  mount ::Resources::Endpoints
end
