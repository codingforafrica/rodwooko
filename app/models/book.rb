class Book < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user
  has_many :sales

  has_attached_file :image
  validates_attachment_content_type :image,
  content_type:  /^image\/(png|gif|jpeg|jpg)/,
  message: "Seulement les images de type gif, png, jpg, jpeg"

  has_attached_file :resource
  validates_attachment_content_type :resource,
  content_type:  ['application/pdf'],
  message: "Seulement les documents PDF"

  validates :image, attachment_presence: true
  validates :resource, attachment_presence: true

  validates_numericality_of :price,
  greater_than: 49, message: "Montant doit être supérieur à 50 cents"

end
