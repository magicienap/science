module Science
  # Version of the library.
  module Version
    # Major number
    MAJOR = 0
    # Minor number
    MINOR = 0
    # Patch number
    PATCH = 0
    # Build
    BUILD = nil

    # Representation of the version as a string.
    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')
  end
end
