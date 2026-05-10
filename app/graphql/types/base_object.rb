# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge) # base edge
    connection_type_class(Types::BaseConnection) # use custom base connection: with additional total_count field
    field_class Types::BaseField
  end
end
