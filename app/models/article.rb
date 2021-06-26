class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    # length 長さをチェック
    # format 正規表現と一致するかチェック
    # numericality 数字のチェック
    # presence 入力されているかチェック
    # uniqueness 一意であるかチェック
end
