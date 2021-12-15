# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_211_215_143_255) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.integer 'record_id', null: false
    t.integer 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.string 'service_name', null: false
    t.integer 'byte_size', null: false
    t.string 'checksum'
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'active_storage_variant_records', force: :cascade do |t|
    t.integer 'blob_id', null: false
    t.string 'variation_digest', null: false
    t.index %w[blob_id variation_digest], name: 'index_active_storage_variant_records_uniqueness', unique: true
  end

  create_table 'answers', force: :cascade do |t|
    t.text 'body', null: false
    t.integer 'question_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'user_id', null: false
    t.index ['question_id'], name: 'index_answers_on_question_id'
    t.index ['user_id'], name: 'index_answers_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.string 'body'
    t.string 'commentable_type', null: false
    t.integer 'commentable_id', null: false
    t.integer 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[commentable_type commentable_id], name: 'index_comments_on_commentable'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'question_tags', force: :cascade do |t|
    t.integer 'question_id', null: false
    t.integer 'tag_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[question_id tag_id], name: 'index_question_tags_on_question_id_and_tag_id', unique: true
    t.index ['question_id'], name: 'index_question_tags_on_question_id'
    t.index ['tag_id'], name: 'index_question_tags_on_tag_id'
  end

  create_table 'questions', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'body', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'user_id', null: false
    t.index ['user_id'], name: 'index_questions_on_user_id'
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'title'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['title'], name: 'index_tags_on_title', unique: true
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'name'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'remember_token_digest'
    t.string 'gravatar_url'
    t.string 'gravatar_hash'
    t.integer 'role', default: 0, null: false
    t.datetime 'password_reset_at'
    t.string 'password_reset_token'
    t.datetime 'password_reset_token_sent_at'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['password_reset_token'], name: 'index_users_on_password_reset_token'
    t.index ['role'], name: 'index_users_on_role'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'active_storage_variant_records', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'answers', 'questions'
  add_foreign_key 'answers', 'users'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'question_tags', 'questions'
  add_foreign_key 'question_tags', 'tags'
  add_foreign_key 'questions', 'users'
end
