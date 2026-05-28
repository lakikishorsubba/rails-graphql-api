class Post < ApplicationRecord
  include AASM # bring all the aasm method as instance here
  belongs_to :user

  # puts :user.object_id, just to check the Symbol
  validates :status, presence: true

  enum :status, { draft: 0, published: 1 }
  # open the aasm block, direct access to column status using symbol
  aasm(column: :status, enum: true, whiny_persistence: true) do # aasm is a method and passing arguement to it
    # state defines the possible values
    state :draft, initial: true # calling state method with arguement. Can do: state(:draft, initial: true)
    state :published

  # event defines the transition
  event(:publish) do
    transitions(from: :draft, to: :published)
  end
  event(:unpublish) do
    transitions(from: :published, to: :draft)
  end
  end
end
