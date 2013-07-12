class Page::Page
  include MongoMapper::Document

  key :title, String
  key :keyword, String
  key :parent, String
  key :public, Boolean
  key :content, Type
end
