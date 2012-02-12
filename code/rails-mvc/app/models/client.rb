class Client < ActiveRecord::Base
  def self.auth data
    find_by_email_and_password data[:email], data[:password]
  end

  has_many :orders

  scope :from_south, where(state: ["rs", "sc", "pr"])

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: {with: /\w+@gmail\.com/}
  validates :state, inclusion: {in: %w[rs sp rj sc pr es], allow_nil: true}
  validates :age, numericality: {greater_than: 17, only_integer: true, allow_nil: true}
  validates :terms, acceptance: {accept: 'yes'}
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, :presence => true

  validate :strength_of_password
  protected
  def strength_of_password
    return unless password
    if password.count(password[0]) == password.length
      errors.add(:password, "too weak")
    end
  end

end
