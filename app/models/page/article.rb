class Page::Article < Page::Type
  include MongoMapper::Document

  key :content, String
  key :author, String

end
