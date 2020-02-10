class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :relationships
  # 中間テーブル。followingsにアクセスする際にはfollow_idを使うように指定
  has_many :followings, through: :relationships, source: :follow
  # foregin_key = 入口,source = 出口
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  
  # unless self == other_user によって、フォローしようとしている other_user が自分自身ではないかを検証
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  # relationship が存在すれば destroy
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  # フォローしているUser達を取得し、other_user が含まれていないかを確認。含まれていれば、true、含まれていなければfalseを返す。
  def following?(other_user)
    self.followings.include?(other_user)
  end

  attachment :profile_image, destroy: false
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
