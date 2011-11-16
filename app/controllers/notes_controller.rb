class NotesController < AuthorizedController
  belongs_to :employee, :polymorphic => true

  def index
    @note_of_sth = find_note_of_sth
    @notes = @note_of_sth.notes.paginate(:page => params[:page])

    index!
  end

  def new
    @note = Note.new(:note_of_sth => parent, :user => current_user)

    new!
  end

  def create
    @note_of_sth = find_note_of_sth
    @note = @note_of_sth.notes.build(params[:note])

    create! do |format|
      format.html { redirect_to eval("#{parent_type}_notes_path(@note_of_sth)") }
    end
  end

  private

  def find_note_of_sth
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
  end
end