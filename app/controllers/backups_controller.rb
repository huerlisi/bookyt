# Backup Controller
class BackupsController < AttachmentsController
  defaults :resource_class => Backup

  def create
    @backup = current_tenant.export
    redirect_to current_tenant
  end

  def restore
    # TODO: access validation
    @backup = Backup.find(params[:id])
    @backup.import
    redirect_to current_tenant
  end
end
