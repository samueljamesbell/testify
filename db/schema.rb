# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090918154358) do

  create_table "actions", :force => true do |t|
    t.string   "object_type"
    t.integer  "object_id"
    t.string   "action_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "codes", :force => true do |t|
    t.string   "code"
    t.boolean  "used"
    t.integer  "review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demands", :force => true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "email"
    t.string   "code"
    t.boolean  "code_used"
    t.integer  "user_id"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "work"
  end

  create_table "reviews", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "name"
    t.string   "company"
    t.string   "work"
    t.integer  "demand_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "handle"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.string   "url"
  end

end
