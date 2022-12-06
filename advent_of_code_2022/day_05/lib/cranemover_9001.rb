class CraneMover9001
  def apply(state, move_values)
    qty, src, dest = move_values
    
    crate = state[src].pop(qty)
    # pp "DEBUG: crate #{crate}, state[#{src}]: #{state[src]}"
    state[dest] << crate
    state[dest].flatten!

    state
  end
end