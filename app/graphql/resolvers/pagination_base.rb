module Resolvers
  class PaginationBase < GraphQL::Schema::Resolver
    # base pagination arguement: can be used in other queries
    argument :after,  String,  required: false, default_value: nil
    argument :before, String,  required: false, default_value: nil
    argument :first,  Integer, required: false, default_value: 10
    argument :last,   Integer, required: false, default_value: nil
    argument :skip,   Integer, required: false, default_value: 0
  end
end
