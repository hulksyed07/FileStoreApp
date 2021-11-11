class AddAttachmentAvatarToUserFiles < ActiveRecord::Migration[6.1]
  def self.up
    change_table :user_files do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :user_files, :avatar
  end
end
