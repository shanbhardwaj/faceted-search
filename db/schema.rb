# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130221101759) do

  create_table "articles", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.datetime "published_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "retailer_ledgers", :force => true do |t|
    t.integer  "wine_id"
    t.integer  "retailer_id"
    t.integer  "in_stock",           :limit => 1
    t.decimal  "price",                           :precision => 9,  :scale => 2
    t.integer  "reds"
    t.integer  "whites"
    t.integer  "rose"
    t.integer  "sparkling"
    t.integer  "dessert"
    t.integer  "other"
    t.boolean  "logical_deleted",                                                 :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "price_at"
    t.datetime "stock_at"
    t.decimal  "by_the_glass_price",              :precision => 9,  :scale => 2,  :default => 0.0
    t.string   "bottlesize"
    t.decimal  "lat",                             :precision => 15, :scale => 10
    t.decimal  "lng",                             :precision => 15, :scale => 10
    t.string   "retailer_type"
  end

  create_table "retailers", :force => true do |t|
    t.string   "phone_number",       :limit => 15
    t.string   "retailer_name",      :limit => 80
    t.string   "address"
    t.string   "address_line_2"
    t.string   "city",               :limit => 30
    t.string   "state",              :limit => 30
    t.integer  "zip_code"
    t.string   "neighborhood"
    t.string   "country",            :limit => 30
    t.string   "region",             :limit => 30
    t.string   "website"
    t.string   "retailer_type"
    t.string   "wine_director_name"
    t.boolean  "tastings"
    t.string   "specialty"
    t.float    "corkage_fee"
    t.decimal  "lat",                              :precision => 15, :scale => 10
    t.decimal  "lng",                              :precision => 15, :scale => 10
    t.boolean  "BYOW"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "M_F_on_hours",       :limit => 10
    t.string   "M_F_off_hours",      :limit => 10
    t.string   "saturday_on_hours",  :limit => 10
    t.string   "saturday_off_hours", :limit => 10
    t.string   "sunday_on_hours",    :limit => 10
    t.string   "sunday_off_hours",   :limit => 10
    t.boolean  "by_the_glass"
  end

  create_table "wines", :force => true do |t|
    t.integer  "producer_id"
    t.string   "wine_name"
    t.string   "producer",                           :limit => 50
    t.string   "varietal",                           :limit => 50
    t.string   "varietal2",                          :limit => 50
    t.string   "year"
    t.integer  "vintage"
    t.string   "wine_type",                          :limit => 50
    t.string   "region",                             :limit => 100
    t.string   "sub_region",                         :limit => 50
    t.string   "other_region"
    t.string   "grape1",                             :limit => 30
    t.float    "percentage_grape1"
    t.string   "grape2",                             :limit => 30
    t.float    "percentage_grape2"
    t.string   "grape3",                             :limit => 30
    t.float    "percentage_grape3"
    t.string   "grape4",                             :limit => 30
    t.float    "percentage_grape4"
    t.string   "grape5",                             :limit => 30
    t.float    "percentage_grape5"
    t.string   "bottlesize"
    t.string   "acidity",                            :limit => 10
    t.string   "alcohol_content",                    :limit => 10
    t.integer  "upc"
    t.float    "wine_spectator_rating"
    t.string   "wine_spectator_review",              :limit => 500
    t.string   "wine_spectator_reviewer"
    t.date     "wine_spectator_review_date"
    t.float    "wine_advocate_rating"
    t.string   "wine_advocate_review",               :limit => 500
    t.string   "wine_advocate_reviewer"
    t.date     "wine_advocate_review_date"
    t.float    "steven_tanzer_rating"
    t.string   "steven_tanzer_review",               :limit => 500
    t.string   "steven_tanzer_reviewer"
    t.date     "steven_tanzer_review_date"
    t.float    "gary_v_rating"
    t.string   "gary_v_rating_review",               :limit => 500
    t.string   "gary_v_reviewer"
    t.date     "gary_v_review_date"
    t.float    "food_and_wine_magazine_rating"
    t.string   "food_and_wine_magazine_review",      :limit => 500
    t.string   "food_and_wine_reviewer"
    t.date     "food_and_wine_magazine_review_date"
    t.float    "wine_enthusiast_rating"
    t.string   "wine_enthusiast_review",             :limit => 500
    t.string   "wine_enthusiast_reviewer"
    t.date     "wine_enthusiast_review_date"
    t.float    "other_1_rating"
    t.string   "other_1_review",                     :limit => 500
    t.string   "other_1_reviewer"
    t.date     "other_1_review_date"
    t.float    "unscrewed_rating"
    t.string   "unscrewed_review",                   :limit => 500
    t.integer  "users_like"
    t.integer  "users__dont_like"
    t.string   "percentage_users_like",              :limit => 10
    t.float    "avg_critic_rating"
    t.float    "lowest_retail_price"
    t.float    "avg_users_rating"
    t.float    "unscrewed_value_rating"
    t.string   "taste"
    t.string   "style"
    t.string   "pairings"
    t.string   "similar_wines"
    t.string   "review_tags"
    t.float    "avg_store_price"
    t.float    "low_store_price"
    t.float    "high_store_price"
    t.float    "avg_bar_price"
    t.float    "low_bar_price"
    t.float    "high_bar_price"
    t.float    "avg_restaurant_price"
    t.float    "low_restaurant_price"
    t.float    "high_restaurant_price"
    t.float    "avg_BTG_price"
    t.float    "low_BTG_price"
    t.float    "high_BTG_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "varietal3",                          :limit => 50
  end

end
