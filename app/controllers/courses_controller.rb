class CoursesController < ApplicationController
  def index
    @courses = Course.all.order({ :created_at => :asc })

    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @course = Course.where({:id => the_id }).at(0)

    render({ :template => "courses/show" })
  end

  #4 Course.new creates a new Instance = new row for the database "courses". The rest of the information needed for the columns in the database is defined by the column names (i.e .title, .term_offered). If you do NOT know the column names, check the app/models folder. There are automatic notes left in the individual files highlighting the name + data type.
  def create
    @course = Course.new
    @course.title = params.fetch("query_title")
    @course.term_offered = params.fetch("query_term")
    @course.department_id = params.fetch("query_department_id")

    if @course.valid?
      @course.save
      redirect_to("/courses", { :notice => "Course created successfully." })
    else
      redirect_to("/courses", { :notice => "Course failed to create successfully." })
    end
  end

  #5 These params fetch will always come from the .html.erb files. If you need to double check, go to the corresponding file and find the <form> tags.
  def update
    id = params.fetch("path_id")
    @course = Course.where({ :id => id }).at(0)

    @course.title = params.fetch("query_title")
    @course.term_offered = params.fetch("query_term_offered")
    @course.department_id = params.fetch("query_department_id")

    if @course.valid?
      @course.save
      redirect_to("/courses/#{@course.id}", { :notice => "Course updated successfully."} )
    else
      redirect_to("/courses/#{@course.id}", { :alert => "Course failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @course = Course.where({ :id => the_id }).at(0)

    @course.destroy

    redirect_to("/courses", { :notice => "Course deleted successfully."} )
  end
end
