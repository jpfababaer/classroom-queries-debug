class DepartmentsController < ApplicationController
  def index
    @departments = Department.all.order({ :id => :asc })

    render({ :template => "departments/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @department = Department.where({:id => the_id }).at(0)

    render({ :template => "departments/show" })
  end

  def create
    @department = Department.new
    @department.name = params.fetch("query_name")

  #Q1 How does this method "create" connect back to the .erb files index.html.erb - There is some background logic ("syntactic sugar") that Rails offers. For now, just need to know this works.

  #Q2 The attribute "action" with insert_department, is that just a placeholder URL? So when the form is actually submitted, the "redirect_to" points the new page back to /departments instead of /insert_department? Yes, this points back to the main route follows that logic.

  #Q3 What does the symbol :notice do or refer to? When I place a valid department name, I don't see the message "Department created successfully" so is the second argument necessary (same for when it fails)?

  #Q4 Best place to read documentation for ActiveRecord methods, etc. -> RailsonRubyguides

  #NOTES -> SEARCH app/views/courses/index
    if @department.valid?
      @department.save
      redirect_to("/departments", { :notice => "Department created successfully." })
    else
      redirect_to("/departments", { :notice => "Department failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    @department.name = params.fetch("query_name")

    if @department.valid?
      @department.save
      redirect_to("/departments/#{@department.id}", { :notice => "Department updated successfully."} )
    else
      redirect_to("/departments/#{@department.id}", { :alert => "Department failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @department = Department.where({ :id => the_id }).at(0)

    @department.destroy

    redirect_to("/departments", { :notice => "Department deleted successfully."} )
  end
end
