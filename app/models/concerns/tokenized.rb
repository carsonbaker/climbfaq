require 'active_support/concern'

module Tokenized
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :token, :use => :slugged

    def token
      raise(StandardError, "Calling #token on persisted object. Are you sure you meant to do that?") if persisted?
      length = 12
      rand(36**length).to_s(36)
    end
  end

end
