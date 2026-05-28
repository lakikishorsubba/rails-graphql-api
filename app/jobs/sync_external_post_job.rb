class SyncExternalPostJob < ApplicationJob
  # default for regular sync job
  queue_as :default

  def perform
  end
end

