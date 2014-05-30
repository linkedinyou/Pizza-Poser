class HatesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @hate = Hate.new
    @post.hates << @hate
    # @hate = Hate.new(post: @post) alternative version of line 6
    @hate.user = current_user
    @hate.save!
    flash[:notice] = "Thanks for the hate!"
  rescue ActiveRecord::RecordInvalid
    flash[:notice] = "Can´t touch this, also you need to be logged in!"
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Record has been deleted already"
  ensure
    redirect_to('/posts')
  end

  def destroy
  	@hate = current_user.hates.find(params[:id])
    @hate.destroy!
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Can´t delete a hate that is not yours!"
  ensure
    redirect_to('/')
  end
end