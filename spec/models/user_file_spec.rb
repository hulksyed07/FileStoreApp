require 'rails_helper'

RSpec.describe UserFile, :type => :model do
  before do
    user = create(:user)
  end

  it "should raise error when total size exceeds 5 MB" do
    user = User.first
    uf_1 = user.user_files.build(avatar: File.open("#{Rails.root}/spec/fixtures/images/Dummy_World_Map_Mini.png"))
    expect(uf_1.save).to eq true

    7.times do
      uf = user.user_files.build(avatar: File.open("#{Rails.root}/spec/fixtures/images/Dummy_World_Map.png"))
      expect(uf.save).to eq true
    end

    uf_9 = user.user_files.build(avatar: File.open("#{Rails.root}/spec/fixtures/images/Dummy_World_Map.png"))
    expect(uf_9.save).to eq false
    expect(uf_9.errors[:avatar]).to eq ["Total Storage size exceeds 5 MB"]
  end
end
