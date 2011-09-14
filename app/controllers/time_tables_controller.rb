class TimeTablesController < ApplicationController
  respond_to :html, :xml

  def index
    @time_tables = TimeTable.all
    respond_with(@time_tables)
  end

  def show
    @time_table = TimeTable.find(params[:id])
    respond_with(@time_table)
  end

  def new
    @time_table = TimeTable.new
    5.times do
       day = @time_table.days.build
       5.times {day.sessions.build}
    end
    respond_with(@time_table)
  end

  def edit
    @time_table = TimeTable.find(params[:id])
    respond_with(@time_table)
  end

  def create
    @time_table = TimeTable.new(params[:time_table])
    if @time_table.save
      flash[:notice] = 'Time table was successfully created.'
    end
    respond_with(@time_table)
  end

  def update
    @time_table = TimeTable.find(params[:id])

    respond_to do |format|
      if @time_table.update_attributes(params[:time_table])
        flash[:notice] = "Time table was successfully updated."
      end
      respond_with(@time_table)
    end
  end

  def destroy
    @time_table = TimeTable.find(params[:id])
    @time_table.destroy
    redirect_to(time_tables_path)
  end
end
