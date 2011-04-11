module AssetHelper
  def asset_states_as_collection
    states = Asset::STATES
    states.inject({}) do |result, state|
      result[t(state, :scope => 'asset.state')] = state
      result
    end
  end
end
