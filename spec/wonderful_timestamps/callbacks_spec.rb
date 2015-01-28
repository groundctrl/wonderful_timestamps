require 'spec_helper'

module WonderfulTimestamps
  RSpec.describe Callbacks do
    describe '#before_save' do
      context 'when record responds to dcreate' do
        it 'set dcreate to Time.now' do
          time_now = Time.parse('Oct 12 1979')
          allow(Time).to receive(:now).and_return time_now
          record = OpenStruct.new(dcreate: nil)

          Callbacks.new.before_save record

          expect(record.dcreate).to eq time_now
        end
      end

      context 'when record is missing dcreate' do
        it 'does not set timestamp' do
          record = double(
            'Record',
            :dcreate= => true,
            :dupdate= => true,
            :persisted? => false
          )
          allow(record).to receive(:respond_to?).and_return true
          allow(record).to receive(:respond_to?).
            with(:dcreate).and_return false

          Callbacks.new.before_save record

          expect(record).not_to have_received(:dcreate=)
        end
      end

      context 'when record responds to dupdate' do
        it 'sets dupdate' do
          time_now = Time.parse('Oct 12 1979')
          record = OpenStruct.new(dcreate: nil, dupdate: nil)
          allow(Time).to receive(:now).and_return time_now

          Callbacks.new.before_save record

          expect(record.dupdate).not_to be_nil
        end
      end

      context 'when record is missing dupdate' do
        it 'does not set timestamp' do
          record = double(
            'Record',
            :dcreate= => true,
            :dupdate= => true,
            :persisted? => false
          )
          allow(record).to receive(:respond_to?).and_return(true)
          allow(record).to receive(:respond_to?).
            with(:dupdate).and_return(false)

          Callbacks.new.before_save record

          expect(record).not_to have_received(:dupdate=)
        end
      end

      context 'when record is new' do
        it 'both timestamps get set' do
          time_now = Time.parse('Oct 12 1979')
          record = double 'Record', persisted?: false
          allow(record).to receive(:respond_to?).and_return true
          allow(record).to receive(:dcreate=).with time_now
          allow(record).to receive(:dupdate=).with time_now
          allow(Time).to receive(:now).and_return time_now

          Callbacks.new.before_save record

          expect(record).to have_received(:dcreate=).with time_now
          expect(record).to have_received(:dupdate=).with time_now
        end
      end

      context 'when record is persisted' do
        it 'only sets dupdate' do
          time_now = Time.parse('Oct 12 1979')
          record = double 'Record', persisted?: true
          allow(record).to receive(:respond_to?).and_return true
          allow(record).to receive(:dcreate=).with time_now
          allow(record).to receive(:dupdate=).with time_now
          allow(Time).to receive(:now).and_return time_now

          Callbacks.new.before_save record

          expect(record).not_to have_received(:dcreate=)
          expect(record).to have_received(:dupdate=).with time_now
        end
      end
    end
  end
end
