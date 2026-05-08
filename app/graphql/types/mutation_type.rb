# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::Post::CreatePost
    field :update_post, mutation: Mutations::Post::UpdatePost
    field :delete_post, mutation: Mutations::Post::DeletePost
  end
end
