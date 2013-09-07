class Page::Page
	include MongoMapper::Document

	key :id, String
	key :title, String
	key :keyword, String
	key :parent, String
	key :public, Boolean
	key :content, Type
	key :order, Integer
end
