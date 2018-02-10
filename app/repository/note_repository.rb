class NoteRepository < ROM::Repository[:notes]
  def self.build
    new(ROM_CONTAINER)
  end

  commands :create, update: :by_pk, delete: :by_pk

  def all
    notes.to_a
  end
end
