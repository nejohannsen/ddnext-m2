class Alignment
  include MongoMapper::EmbeddedDocument
  embedded_in :character

  key :value, :in => StaticData::ALIGNMENT_OPTIONS
  key :meta

  def complete?
    return self.value.present? ? true : false
  end

  def self.options
    return StaticData::ALIGNMENT_OPTIONS
  end

end
