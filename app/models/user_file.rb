class UserFile < ApplicationRecord
  belongs_to :user
  ATTACHMENT_LIMIT_IN_MB = 5
  ATTACHMENT_LIMIT_IN_BYTES = ATTACHMENT_LIMIT_IN_MB * 1024 * 1024

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, path: "#{Rails.root}/tmp/storage/:class/:attachment/:id_partition/:style/:filename"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_attachment_size :avatar, :less_than => ATTACHMENT_LIMIT_IN_MB.megabytes
  validate :total_storage_limit_not_reached?

  private
  def total_storage_limit_not_reached?
    puts user.user_files.sum{ |uf| uf.avatar.size }
    if user.user_files.sum{ |uf| uf.avatar.size } > ATTACHMENT_LIMIT_IN_BYTES
      errors.add(:avatar, "Total Storage size exceeds #{ATTACHMENT_LIMIT_IN_MB} MB")
    end
  end
end
