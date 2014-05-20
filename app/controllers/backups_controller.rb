# Backup Controller
class BackupsController < AttachmentsController
  defaults :resource_class => Backup

  def create
    @backup = Backup.new(params[:backup])
    if @backup.save
      @backup.import

      redirect_to current_tenant
    else
      render :new
    end
  end

  def dump
    tenant = Tenant.find(params[:tenant_id])

    @backup = tenant.backups.build
    @backup.dump
    @backup.save!

    redirect_to current_tenant
  end

  def restore
    # TODO: access validation
    @backup = Backup.find(params[:id])
    @backup.import

    redirect_to current_tenant
  end
end
