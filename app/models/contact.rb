class Contact < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :relationship, presence: true

  enum relationship: { personal: 'personal', professional: 'professional' }
end
