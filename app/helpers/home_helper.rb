module HomeHelper

  def git_revision
    GIT_REVISION
  end

  def git_revision_url
    "https://github.com/gkop/bbase/commit/"+git_revision
  end

end
