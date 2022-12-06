class Cranemaster9000
  def apply(state, move_values)
    qty, src, dest = move_values
    
    qty.times do
      crate = state[src].pop
      # pp "DEBUG: crate #{crate}, state[#{src}]: #{state[src]}"
      state[dest] << crate
      state[dest].flatten!
    end

    state
  end
end