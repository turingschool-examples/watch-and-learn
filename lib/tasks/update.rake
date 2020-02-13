# frozen_string_literal: true

namespace :update do
  task position: :environment do
    Video.where(position: nil).update_all(position: 0)
  end
end
