class SyncExternalPostJob < ApplicationJob
  # default for regular sync job
  queue_as :default

  def perform
    PostsFaradayServices.new.fetch_all.each do |data|
      Post.find_or_create_by(title: data["title"].to_s.strip) do |post|
        post.body = data["body"].to_s.strip
        post.status = :published
        post.user_id = sync_user.id
      end
    end
  end

  private
  def sync_user
    User.find_or_create_by!(email: "sync@gmail.com") do |u|
      u.password = SecureRandom.hex(32)
      u.password_confirmation = u.password
    end
  end
end
