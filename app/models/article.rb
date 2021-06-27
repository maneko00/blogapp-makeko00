# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    # presence 入力されているかチェック
    validates :title, presence: true
    # length 長さをチェック
    validates :title, length: { minimum: 2, maximum: 100 }
    # format 正規表現と一致するかチェック
    validates :title, format: { with:/\A(?!\@)/ }

    validates :content, presence: true
    validates :content, length: { minimum: 10 }
    # uniqueness 一意であるかチェック
    validates :content, uniqueness: true

    validate :validate_title_and_content_length

    belongs_to :user

    # numericality 数字のチェック
    def display_created_at
        I18n.l(self.created_at, format: :default)
    end

    private
    def validate_title_and_content_length
        char_count = self.title.length + self.content.length
        errors.add(:content, '100文字以上で！') unless char_count > 100
    end

end
