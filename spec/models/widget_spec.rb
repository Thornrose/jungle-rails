require 'rails_helper'

describe 'Widget#id' do
  it 'should not exist for new records' do
    @widget = Widget.new
    expect(@widget.id).to be_nil
  end

  it 'should be auto-assigned by AR for saved records' do
    @widget = Widget.new
    @widget.save!
    expect(@widget.id).to be_present
  end

end
