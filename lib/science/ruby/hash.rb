# Extensions to Ruby builtin Hash class.
class Hash

  # Determines if the hash has all the keys provided as arguments.
  # @param [Array] keys Keys that should be in the hash.
  # @return [Boolean] `true` if all the keys are in the hash, `false` orthewise.
  def has_keys?(keys)
    keys.each do |key|
      return false unless has_key?(key)
    end
    
    true
  end
end
