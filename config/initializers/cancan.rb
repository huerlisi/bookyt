CanCan::InheritedResource

class CanCan::InheritedResource
  def resource_base
    @controller.send :collection
  end
end