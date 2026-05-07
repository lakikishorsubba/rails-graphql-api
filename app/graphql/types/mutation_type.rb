# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::Post::CreatePost
  end
end
