module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: true
    field :author, Types::UserType, null: true, method: :user

    def author
      dataloader.with(::Sources::RecordSource, ::User).load(object.user_id)
    end
  end
end
