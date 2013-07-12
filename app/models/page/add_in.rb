class Page::AddIn < Page::Type
  include MongoMapper::Document

  key :controller, String
  key :action, String

end
