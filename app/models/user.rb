class User < ApplicationRecord
  # 會提供兩個虛擬欄位 password & password_confirmation 都是字串
  # 當兩個虛擬欄位 match 之後會由 bcrypt 產生 password_digest 存到 database
  # has_secure_password(options={validations:false}) # 關閉驗證
  has_secure_password

  # email 必須要存在且唯一, 格式需要有小老鼠
  # validates :email, presence: { message: '不能空白' },
  #                   uniqueness: { message: '已經被使用'},
  #                   format: { with: /\A[^@\s]+@[^@\s]+\z/, message: '格式不正確' }

  # validates :password, presence: { message: '不能空白' },
  #                      length: {
  #                         minimum: 6,
  #                         maximum: 12,
  #                         too_short: '密碼最少 6 位數(含英文)',
  #                         too_long: '密碼最多 12 位數(含英文)'
  #                       },
  #                       confirmation: { message: '與密碼不符合' }
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :password_confirmation
  has_many :tasks, dependent: :destroy
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  ROLES = ['admin', 'general_user']

  def admin?
    role == 'admin'
  end
end
