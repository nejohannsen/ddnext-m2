class Player
  include MongoMapper::EmbeddedDocument

  key :name
  key :dci_number
  key :meta

  def complete?
    return self.name.present? ? true : false
  end

end
