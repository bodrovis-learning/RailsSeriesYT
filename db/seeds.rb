# frozen_string_literal: true

# 30.times do
#   title = Faker::Hipster.sentence(word_count: 3)
#   body = Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)
#   Question.create title: title, body: body
# end

# User.find_each do |u|
#   u.send(:set_gravatar_hash)
#   u.save
# end

30.times do
  title = Faker::Hipster.word
  Tag.create title: title
end
