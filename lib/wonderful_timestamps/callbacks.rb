module WonderfulTimestamps
  class Callbacks
    LEGACY_FIELDS = %i(dcreate dupdate)

    def before_save(record)
      attrs_for(record).each { |field| update_time(record, field) }
    end

    private

    def attrs_for(record)
      record.persisted? ? [:dupdate] : LEGACY_FIELDS
    end

    def update_time(record, field)
      record.send(:"#{field}=", Time.now) if record.respond_to? field
    end
  end
end
