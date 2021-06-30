# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
	has_one_attached :eyecatch
	has_rich_text :content

	# presence 入力されているかチェック
	validates :title, presence: true
	# length 長さをチェック
	validates :title, length: { minimum: 2, maximum: 100 }
	# format 正規表現と一致するかチェック
	validates :title, format: { with:/\A(?!\@)/ }

	validates :content, presence: true

	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	belongs_to :user

	# numericality 数字のチェック
	def display_created_at
		I18n.l(self.created_at, format: :default)
	end

    def author_name
		user.display_name
    end

    def like_count
		likes.count
    end
end
