module Sources
  class RecordSource < GraphQL::Dataloader::Source
    def initialize(model)
      @model = model
    end
    def fetch(ids)
      # fetch the user ids at once no N+1 query
      records = @model.where(id: ids).index_by(&:id)

      # blocks that returns exact format as post requested
      ids.map do |id|
        records[id]
      end
    end
  end
end
