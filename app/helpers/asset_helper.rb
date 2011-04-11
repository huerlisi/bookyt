module AssetHelper
  # Translate asset state
  def t_asset_state(state)
    t(state, :scope => 'asset.state')
  end
  
  # Provide translated asset states for select fields
  def asset_states_as_collection
    states = Asset::STATES
    states.inject({}) do |result, state|
      result[t_asset_state(state)] = state
      result
    end
  end
end
