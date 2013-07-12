class User::Author < User
  include MongoMapper::Document
  many :pages

end
