# frozen_string_literal: true

module SlackRubyBotServer
  module Slack
    module Api
      module Endpoints
        module Slack
          class ActionsEndpoint < Grape::API
            desc 'Respond to interactive slack buttons and actions.'
            params do
              requires :payload, type: JSON do
                requires :token, type: String
                requires :callback_id, type: String
                optional :type, type: String
                optional :trigger_id, type: String
                optional :response_url, type: String
                requires :channel, type: Hash do
                  requires :id, type: String
                  optional :name, type: String
                end
                requires :user, type: Hash do
                  requires :id, type: String
                  optional :name, type: String
                end
                requires :team, type: Hash do
                  requires :id, type: String
                  optional :domain, type: String
                end
                optional :actions, type: Array do
                  requires :value, type: String
                end
                optional :message, type: Hash do
                  requires :type, type: String
                  requires :user, type: String
                  requires :ts, type: String
                  requires :text, type: String
                end
              end
            end
            post '/action' do
              action = SlackRubyBotServer::Slack::Requests::Action.new(params, request)
              SlackRubyBotServer::Slack.config.run_callbacks(:action, action) || body(false)
            end
          end
        end
      end
    end
  end
end