# == Schema Information
#
# Table name: books
#
#  id                   :bigint           not null, primary key
#  name                 :string
#  link                 :string
#  pages_per_day        :integer          default(10)
#  current_reading_page :integer          default(1)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :integer
#

class Book < ApplicationRecord
  has_many :book_pages
  has_many :user_books
  has_many :users, through: :user_books
end
