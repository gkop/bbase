module HomeHelper

  def git_revision
    GIT_REPO.commits('master',1)[0].sha
  end

  def git_revision_date
    date = GIT_REPO.commits('master',1)[0].date
    date.strftime("%m/%d/%Y at %I:%M%p")
  end

  def git_revision_url
    "https://github.com/gkop/bbase/commit/"+git_revision
  end

end
