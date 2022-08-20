module Groups
  class Access
    OPEN = 'OPEN'
    PRIVATE = 'PRIVATE'

    VALID_ACCESSES = [
      OPEN,
      PRIVATE
    ].freeze
  end
end