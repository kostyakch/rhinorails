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

ActiveRecord::Schema.define(:version => 20130514081446) do

  create_table "page_contents", :force => true do |t|
    t.integer "page_id"
    t.string  "name",     :limit => 100,                :null => false
    t.text    "content"
    t.integer "position",                :default => 0, :null => false
  end

  add_index "page_contents", ["name"], :name => "index_page_contents_on_name"
  add_index "page_contents", ["page_id", "name"], :name => "index_page_contents_on_page_id_and_name", :unique => true

  create_table "page_fields", :force => true do |t|
    t.integer "page_id",                                :null => false
    t.string  "name",     :limit => 120,                :null => false
    t.text    "value"
    t.string  "ftype",    :limit => 60
    t.integer "position",                :default => 0, :null => false
  end

  add_index "page_fields", ["page_id", "name"], :name => "page_fields_page_id_and_name", :unique => true

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name",                                                                          :null => false
    t.string   "slug",                                                                          :null => false
    t.integer  "position",                                                :default => 0,        :null => false
    t.integer  "menu",                                                    :default => 1
    t.boolean  "active",                                                  :default => true
    t.string   "ptype",      :limit => 20,                                :default => "page",   :null => false
    t.string   "sm_p",       :limit => 7,                                 :default => "weekly", :null => false
    t.decimal  "st_pr",                    :precision => 10, :scale => 2, :default => 0.5,      :null => false
    t.datetime "created_at",                                                                    :null => false
    t.datetime "updated_at",                                                                    :null => false
  end

  add_index "pages", ["parent_id", "slug"], :name => "index_pages_on_parent_id_and_slug", :unique => true

  create_table "settings", :force => true do |t|
    t.string "name",  :limit => 120, :default => "", :null => false
    t.string "value",                :default => "", :null => false
    t.text   "descr"
  end

  add_index "settings", ["name", "value"], :name => "index_config_on_name_and_value", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name",            :limit => 250
    t.string   "email",           :limit => 100,                          :null => false
    t.boolean  "active",                         :default => true,        :null => false
    t.string   "roles",                          :default => "ROLE_USER", :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  add_foreign_key "page_contents", "pages", :name => "page_contents_page_id_fk", :dependent => :delete

  add_foreign_key "page_fields", "pages", :name => "page_fields_page_id_fk", :dependent => :delete

  add_foreign_key "pages", "pages", :name => "pages_parent_id_fk", :column => "parent_id", :dependent => :delete

end
