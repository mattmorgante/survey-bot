class Update < ApplicationRecord
  enum mood: [:good, :normal, :bad]

  belongs_to :user
end