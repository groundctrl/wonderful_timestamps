require 'spec_helper'

class TestMigration < ActiveRecord::Migration
  def self.up
    create_table :events, force: true do |tbl|
      tbl.column :foo, :string
      tbl.column :dcreate, :datetime
      tbl.column :dupdate, :datetime
    end

    remove_column :events, :created_at
    remove_column :events, :updated_at
  end
end

class Event < ActiveRecord::Base
  include WonderfulTimestamps::Legacy
end

module WonderfulTimestamps
  RSpec.describe Legacy do
    before(:all) { TestMigration.up }
    after(:all) { TestMigration.down }

    it 'populates legacy columns on save' do
      time_now = Time.parse('10/12/1979')
      allow(Time).to receive(:now).and_return time_now

      event = Event.create foo: 'bar'

      expect(event.dcreate).to eq time_now
    end

    it 'only updates dupdate on update' do
      event = Event.create foo: 'baz'
      created_at = event.dcreate
      time_now = Time.parse('10/12/1979')
      allow(Time).to receive(:now).and_return time_now

      event.update foo: 'bar'

      expect(event.dupdate).to eq time_now
      expect(event.dcreate).to eq created_at
    end
  end
end
