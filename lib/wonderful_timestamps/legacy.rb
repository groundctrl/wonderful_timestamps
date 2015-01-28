module WonderfulTimestamps
  module Legacy
    extend ActiveSupport::Concern

    included do
      alias_attribute :created_at=, :dcreate=
      alias_attribute :updated_at=, :dupdate=

      before_save WonderfulTimestamps::Callbacks.new
    end
  end
end
